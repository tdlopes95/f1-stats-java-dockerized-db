-- ===== Base =====
CREATE TABLE teams (
  id   SERIAL PRIMARY KEY,
  name TEXT   NOT NULL UNIQUE
);

CREATE TABLE drivers (
  id   SERIAL PRIMARY KEY,
  name TEXT   NOT NULL UNIQUE
);

CREATE TABLE seasons (
  id   SERIAL PRIMARY KEY,
  year INT    NOT NULL UNIQUE CHECK (year >= 1900)
);

CREATE TABLE races (
  id        SERIAL PRIMARY KEY,
  season_id INT    NOT NULL REFERENCES seasons(id) ON DELETE CASCADE,
  name      TEXT   NOT NULL,
  race_date DATE,
  round     INT,
  CONSTRAINT uq_race_per_season UNIQUE (season_id, name)
);

-- A driver's team for a given season (historical)
CREATE TABLE driver_team_memberships (
  id        SERIAL PRIMARY KEY,
  driver_id INT NOT NULL REFERENCES drivers(id) ON DELETE CASCADE,
  team_id   INT NOT NULL REFERENCES teams(id)   ON DELETE RESTRICT,
  season_id INT NOT NULL REFERENCES seasons(id) ON DELETE CASCADE,
  CONSTRAINT uq_membership UNIQUE (driver_id, season_id)
);

-- Sessions within a race event (Race or Sprint)
CREATE TABLE race_sessions (
  id           SERIAL PRIMARY KEY,
  race_id      INT  NOT NULL REFERENCES races(id) ON DELETE CASCADE,
  session_type TEXT NOT NULL CHECK (session_type IN ('RACE','SPRINT')),
  session_no   INT  DEFAULT 1,
  session_date DATE,
  CONSTRAINT uq_session UNIQUE (race_id, session_type, session_no)
);

-- Results snapshot team at time of session (NOT race_id)
CREATE TABLE session_results (
  id         SERIAL PRIMARY KEY,
  driver_id  INT NOT NULL REFERENCES drivers(id)       ON DELETE CASCADE,
  session_id INT NOT NULL REFERENCES race_sessions(id) ON DELETE CASCADE,
  team_id    INT NOT NULL REFERENCES teams(id)         ON DELETE RESTRICT,
  position   INT CHECK (position IS NULL OR position >= 1),
  points     INT NOT NULL CHECK (points >= 0),
  CONSTRAINT uq_driver_session UNIQUE (driver_id, session_id)
);

-- ===== Helpful indexes =====
CREATE INDEX idx_races_season          ON races(season_id);

CREATE INDEX idx_memberships_driver    ON driver_team_memberships(driver_id);
CREATE INDEX idx_memberships_team      ON driver_team_memberships(team_id);
CREATE INDEX idx_memberships_season    ON driver_team_memberships(season_id);

CREATE INDEX idx_results_driver        ON session_results(driver_id);
CREATE INDEX idx_results_session       ON session_results(session_id);
CREATE INDEX idx_results_team          ON session_results(team_id);