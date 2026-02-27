
# F1 Stats — Dev README

A full‑stack, Dockerized F1 statistics app:

- **Backend:** Spring Boot 3 (Java 21 runtime), PostgreSQL, Flyway (SQL migrations), JPA/Hibernate
- **Frontend:** React (Vite, JavaScript), dev proxy to the backend
- **Infrastructure:** Docker Compose (app + db), multi‑stage Docker build for the backend

This README focuses on **local development**, **migrations/data**, **common commands**, and **troubleshooting** on Windows PowerShell.

---

## Project layout

```
f1-stats/                     # repo root
  src/                        # Spring Boot backend source
  pom.xml
  Dockerfile                  # multi-stage build
  docker-compose.yml          # app + db
  ui/                         # React (Vite) frontend
    package.json
    vite.config.js
    src/
```

> If your backend lives under a `backend/` folder instead of root, adjust paths accordingly.

---

## Prerequisites

- Docker Desktop (Compose v2)
- Java (optional locally; Docker build uses Temurin JDK 21)
- Node.js 18+ (for the `ui/` dev server)

---

## First run (Docker)

From repo root:

```powershell
# build & start backend + db
docker compose up -d --build

# watch backend logs
docker compose logs app -f
```

When the app is up, the backend listens on **http://localhost:8080**.

### Quick API sanity checks (PowerShell)
> PowerShell aliases `curl` to `Invoke-WebRequest`. Prefer **`curl.exe`** or **`Invoke-RestMethod`**.

```powershell
curl.exe -s http://localhost:8080/api/seasons
Invoke-RestMethod -UseBasicParsing http://localhost:8080/api/teams | ConvertTo-Json
```

---

## Frontend (Vite dev)

```powershell
cd ui
npm install
npm run dev  # default http://localhost:5173
```

We proxy **/api/** to the backend (see `ui/vite.config.js`). Open **http://localhost:5173**.

### Expected UI flows
- **Home:** select season (e.g., 2025), see **Team/Driver leaderboards** (toggle Race/Sprint/All), click **View races**.
- **Season:** list races; click a race.
- **Race:** buttons for **Race**/**Sprint** (if available), results table.
- **Driver:** totals and **average points per RACE** (sprints excluded) per season.

> If you see empty 2026 leaderboards, that’s expected until you add 2026 results.

---

## Backend endpoints (implemented)

**Core reads**
- `GET /api/seasons`
- `GET /api/season/{seasonId}/races`
- `GET /api/race/{id}`
- `GET /api/race/{id}/sessions`
- `GET /api/race-session/{sessionId}/results`

**Stats**
- `GET /api/stats/season/{seasonId}/team-leaderboard?type=RACE|SPRINT`
- `GET /api/stats/season/{seasonId}/driver-leaderboard?type=RACE|SPRINT`
- `GET /api/stats/driver/{driverId}/summary`
- `GET /api/stats/driver/{driverId}/season/{seasonId}/summary`
- `GET /api/stats/average-points-per-session`
- `GET /api/stats/average-points-per-session-by-team`

**Teams**
- `GET /api/teams`, `GET /api/teams/{id}`
- `POST /api/teams` (dev/testing)

> Developer note: use explicit `@PathVariable("seasonId")` / `@PathVariable("id")` in controllers, or enable compiler parameter names (`<parameters>true</parameters>` in `maven-compiler-plugin`).

---

## Flyway migrations & data

Migrations live in: `src/main/resources/db/migration/`

- V1: schema
- V2: base data (races, sessions, seed results)
- V3+: constraints & further data (e.g., not-null, ids to BIGINT, extra results)

### Adding/changing data the right way
- **Best practice:** add a new migration, e.g., `V5__missing_2025_data.sql`.
- **Dev shortcut:** you can edit an old migration and **reset the DB** so Flyway replays from V1 (see Resetting DB below).

### Apply a new migration
```
mvn -q -DskipTests clean package
docker compose build --no-cache app
docker compose up -d
```
Check applied migrations:
```powershell
docker compose exec db psql -U f1 -d f1 -c "SELECT installed_rank, version, description FROM flyway_schema_history ORDER BY installed_rank;"
```

### Resetting DB (dev only)
**Wipe DB volume and rebuild from migrations**
```powershell
docker compose down -v
mvn -q -DskipTests clean package
docker compose build --no-cache app
docker compose up -d
```

**Alternative:** drop/recreate `public` schema without deleting the volume
```powershell
docker compose exec db psql -U f1 -d f1 -c "DROP SCHEMA public CASCADE; CREATE SCHEMA public; GRANT ALL ON SCHEMA public TO postgres; GRANT ALL ON SCHEMA public TO public;"
docker compose restart app
```

**Optional: stop at V1 for testing**
Add to `docker-compose.yml` → app → environment:
```yaml
- SPRING_FLYWAY_TARGET=1
```
Remove it later to migrate to latest.

---

## Dockerfile (backend)

Multi‑stage build using Temurin JDK 21 for build, JRE 21 for runtime. We use a best‑effort `dependency:go-offline` layer for cache warmth (the actual `clean package` will fetch anything missing):

```dockerfile
FROM maven:3.9.6-eclipse-temurin-21-alpine AS builder
WORKDIR /app
COPY pom.xml ./
RUN mvn -B -U -e -DskipTests dependency:go-offline || true
COPY src ./src
RUN mvn -B -e -DskipTests clean package

FROM eclipse-temurin:21-jre
WORKDIR /app
ENV JAVA_OPTS="-XX:MaxRAMPercentage=75.0 -XX:+UseG1GC"
COPY --from=builder /app/target/*.jar /app/app.jar
EXPOSE 8080
ENTRYPOINT ["sh","-c","java $JAVA_OPTS -jar /app/app.jar"]
```

---

## Common Docker commands

```powershell
# start or recreate in background
docker compose up -d

# rebuild images for app only
docker compose build --no-cache app

# view logs
docker compose logs app -f

# stop (keep containers)
docker compose stop

# down (remove containers + network; keep volumes)
docker compose down

# down AND delete named volumes (⚠ wipes DB data)
docker compose down -v

# list services
docker compose ps
```

---

## Database quick queries (psql)

```powershell
# psql shell
docker compose exec -it db psql -U f1 -d f1

# list seasons
SELECT id, year FROM seasons ORDER BY year;

# races for a season (replace :season_id)
SELECT id, round, name, race_date FROM races WHERE season_id=:season_id ORDER BY round;

# results for a race's RACE session
SELECT d.name, t.name AS team, sr.position, sr.points
FROM session_results sr
JOIN drivers d ON d.id = sr.driver_id
JOIN teams t   ON t.id = sr.team_id
JOIN race_sessions rs ON rs.id = sr.session_id AND rs.session_type='RACE'
WHERE rs.race_id = :race_id
ORDER BY sr.position;
```

---

## Troubleshooting

**Vite page doesn’t load**
- Ensure `npm run dev` is running in `ui/` and that port 5173 is free. Try `npm run dev -- --port 5174`.
- Check browser DevTools → Console/Network for errors.
- Confirm backend is up: `docker compose logs app --tail=80`.

**PowerShell prompts about script execution or 405 on curl**
- Use `curl.exe` (not `curl`) or `Invoke-RestMethod -UseBasicParsing`.
- 405 often means the route exists but HTTP method isn’t implemented; check controller mappings.

**500 with `Name for argument not specified`**
- Add explicit names in `@PathVariable("seasonId")`, etc., or enable `<parameters>true</parameters>` in Maven compiler plugin.

**Lombok errors with newer JDKs**
- Use a Lombok version compatible with your JDK (project uses Java 21 runtime in Docker).
- Ensure Lombok is listed under `annotationProcessorPaths` in `maven-compiler-plugin`.

**Compose warning: `version` key is obsolete**
- Remove top‑level `version:` from `docker-compose.yml`.

---

## API docs (optional)
If using Springdoc OpenAPI:
- UI: `http://localhost:8080/swagger-ui/index.html`
- JSON: `http://localhost:8080/v3/api-docs`

---

## Contributing (for future you)
- Prefer **new migrations** for any data/schema change (e.g., `V6__...sql`).
- Keep controller routes stable; surface data via small DTOs.
- Add integration tests with Testcontainers to exercise real Postgres.

---

## License
Internal/dev project.
