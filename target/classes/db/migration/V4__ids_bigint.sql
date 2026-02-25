-- === Primary keys to BIGINT ===
ALTER TABLE teams                   ALTER COLUMN id TYPE BIGINT;
ALTER TABLE drivers                 ALTER COLUMN id TYPE BIGINT;
ALTER TABLE seasons                 ALTER COLUMN id TYPE BIGINT;
ALTER TABLE races                   ALTER COLUMN id TYPE BIGINT;
ALTER TABLE race_sessions           ALTER COLUMN id TYPE BIGINT;
ALTER TABLE driver_team_memberships ALTER COLUMN id TYPE BIGINT;
ALTER TABLE session_results         ALTER COLUMN id TYPE BIGINT;

-- === Foreign keys / references to BIGINT ===
-- races -> seasons
ALTER TABLE races                   ALTER COLUMN season_id  TYPE BIGINT;

-- race_sessions -> races
ALTER TABLE race_sessions           ALTER COLUMN race_id    TYPE BIGINT;

-- driver_team_memberships -> drivers, teams, seasons
ALTER TABLE driver_team_memberships ALTER COLUMN driver_id TYPE BIGINT;
ALTER TABLE driver_team_memberships ALTER COLUMN team_id   TYPE BIGINT;
ALTER TABLE driver_team_memberships ALTER COLUMN season_id TYPE BIGINT;

-- session_results -> drivers, race_sessions, teams
ALTER TABLE session_results         ALTER COLUMN driver_id  TYPE BIGINT;
ALTER TABLE session_results         ALTER COLUMN session_id TYPE BIGINT;
ALTER TABLE session_results         ALTER COLUMN team_id    TYPE BIGINT;