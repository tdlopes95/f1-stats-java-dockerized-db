-- ================================================
-- Add additional 2025 sessions/results
-- (Idempotent: ON CONFLICT upserts by driver+session)
-- ================================================

-- 1) Queries to add new race/track or sprint/track (there are new races in 2026 and new sprints) <-- apenas de backup para inserir posteriormente

-- SPRINT 
--INSERT INTO race_sessions (race_id, session_type, session_no, session_date)
--SELECT r.id, 'SPRINT', 1, r.race_date
--FROM races r
--JOIN seasons s ON s.id = r.season_id
--LEFT JOIN race_sessions rs
--  ON rs.race_id = r.id AND rs.session_type = 'SPRINT' AND rs.session_no = 1
--WHERE s.year = 2025 AND r.name = 'Belgium GP' AND rs.id IS NULL;

-- RACE 
--INSERT INTO race_sessions (race_id, session_type, session_no, session_date)
--SELECT r.id, 'RACE', 1, r.race_date
--FROM races r
--JOIN seasons s ON s.id = r.season_id
--LEFT JOIN race_sessions rs
--  ON rs.race_id = r.id AND rs.session_type = 'RACE' AND rs.session_no = 1
--WHERE s.year = 2025 AND r.name = 'Belgium GP' AND rs.id IS NULL;

-- 2) Missing 2025 Races/Sprints results
-- ROUND 3: JAPAN (RACE)
INSERT INTO session_results (driver_id, session_id, team_id, position, points)
SELECT d.id, sess.id, m.team_id, x.position, x.points
FROM (
  VALUES
    (1, 25,  'Max Verstappen'),
    (2, 18,  'Lando Norris'),
    (3, 15,  'Oscar Piastri'),
    (4, 12,  'Charles Leclerc'),
    (5, 10,  'George Russell'),
    (6, 8,  'Kimi Antonelli'),
    (7, 6,  'Lewis Hamilton'),
    (8, 4,  'Isack Hadjar'),
    (9, 2,  'Alex Albon'),
    (10, 1,  'Oliver Bearman')
) AS x(position, points, driver_name)
JOIN drivers d ON d.name = x.driver_name
JOIN seasons s ON s.year = 2025
JOIN races r   ON r.season_id = s.id AND r.name = 'Japan GP'
JOIN race_sessions sess ON sess.race_id = r.id AND sess.session_type = 'RACE'
JOIN driver_team_memberships m ON m.driver_id = d.id AND m.season_id = s.id
ON CONFLICT (driver_id, session_id) DO UPDATE
  SET position = EXCLUDED.position,
      points   = EXCLUDED.points;

-- ROUND 4: BAHRAIN (RACE)
INSERT INTO session_results (driver_id, session_id, team_id, position, points)
SELECT d.id, sess.id, m.team_id, x.position, x.points
FROM (
  VALUES
    (1, 25,  'Oscar Piastri'),
    (2, 18,  'George Russell'),
    (3, 15,  'Lando Norris'),
    (4, 12,  'Charles Leclerc'),
    (5, 10,  'Lewis Hamilton'),
    (6, 8,  'Max Verstappen'),
    (7, 6,  'Pierre Gasly'),
    (8, 4,  'Esteban Ocon'),
    (9, 2,  'Yuki Tsunoda'),
    (10, 1,  'Oliver Bearman')
) AS x(position, points, driver_name)
JOIN drivers d ON d.name = x.driver_name
JOIN seasons s ON s.year = 2025
JOIN races r   ON r.season_id = s.id AND r.name = 'Bahrain GP'
JOIN race_sessions sess ON sess.race_id = r.id AND sess.session_type = 'RACE'
JOIN driver_team_memberships m ON m.driver_id = d.id AND m.season_id = s.id
ON CONFLICT (driver_id, session_id) DO UPDATE
  SET position = EXCLUDED.position,
      points   = EXCLUDED.points;

-- ROUND 5: SAUDI (RACE)
INSERT INTO session_results (driver_id, session_id, team_id, position, points)
SELECT d.id, sess.id, m.team_id, x.position, x.points
FROM (
  VALUES
    (1, 25,  'Oscar Piastri'),
    (2, 18,  'Max Verstappen'),
    (3, 15,  'Charles Leclerc'),
    (4, 12,  'Lando Norris'),
    (5, 10,  'George Russell'),
    (6, 8,  'Kimi Antonelli'),
    (7, 6,  'Lewis Hamilton'),
    (8, 4,  'Carlos Sainz'),
    (9, 2,  'Alex Albon'),
    (10, 1,  'Isack Hadjar')
) AS x(position, points, driver_name)
JOIN drivers d ON d.name = x.driver_name
JOIN seasons s ON s.year = 2025
JOIN races r   ON r.season_id = s.id AND r.name = 'Saudi Arabia GP'
JOIN race_sessions sess ON sess.race_id = r.id AND sess.session_type = 'RACE'
JOIN driver_team_memberships m ON m.driver_id = d.id AND m.season_id = s.id
ON CONFLICT (driver_id, session_id) DO UPDATE
  SET position = EXCLUDED.position,
      points   = EXCLUDED.points;

-- ROUND 7: EMILIA ROMAGNA (RACE)
INSERT INTO session_results (driver_id, session_id, team_id, position, points)
SELECT d.id, sess.id, m.team_id, x.position, x.points
FROM (
  VALUES
    (1, 25,  'Max Verstappen'),
    (2, 18,  'Lando Norris'),
    (3, 15,  'Oscar Piastri'),
    (4, 12,  'Lewis Hamilton'),
    (5, 10,  'Alex Albon'),
    (6, 8,  'Charles Leclerc'),
    (7, 6,  'George Russell'),
    (8, 4,  'Carlos Sainz'),
    (9, 2,  'Isack Hadjar'),
    (10, 1,  'Yuki Tsunoda')
) AS x(position, points, driver_name)
JOIN drivers d ON d.name = x.driver_name
JOIN seasons s ON s.year = 2025
JOIN races r   ON r.season_id = s.id AND r.name = 'Emilia Romagna GP'
JOIN race_sessions sess ON sess.race_id = r.id AND sess.session_type = 'RACE'
JOIN driver_team_memberships m ON m.driver_id = d.id AND m.season_id = s.id
ON CONFLICT (driver_id, session_id) DO UPDATE
  SET position = EXCLUDED.position,
      points   = EXCLUDED.points;

-- ROUND 8: MONACO (RACE)
INSERT INTO session_results (driver_id, session_id, team_id, position, points)
SELECT d.id, sess.id, m.team_id, x.position, x.points
FROM (
  VALUES
    (1, 25,  'Lando Norris'),
    (2, 18,  'Charles Leclerc'),
    (3, 15,  'Oscar Piastri'),
    (4, 12,  'Max Verstappen'),
    (5, 10,  'Lewis Hamilton'),
    (6, 8,  'Isack Hadjar'),
    (7, 6,  'Esteban Ocon'),
    (8, 4,  'Liam Lawson'),
    (9, 2,  'Alex Albon'),
    (10, 1,  'Carlos Sainz')
) AS x(position, points, driver_name)
JOIN drivers d ON d.name = x.driver_name
JOIN seasons s ON s.year = 2025
JOIN races r   ON r.season_id = s.id AND r.name = 'Monaco GP'
JOIN race_sessions sess ON sess.race_id = r.id AND sess.session_type = 'RACE'
JOIN driver_team_memberships m ON m.driver_id = d.id AND m.season_id = s.id
ON CONFLICT (driver_id, session_id) DO UPDATE
  SET position = EXCLUDED.position,
      points   = EXCLUDED.points;

-- ROUND 9: SPAIN (RACE)
INSERT INTO session_results (driver_id, session_id, team_id, position, points)
SELECT d.id, sess.id, m.team_id, x.position, x.points
FROM (
  VALUES
    (1, 25,  'Oscar Piastri'),
    (2, 18,  'Lando Norris'),
    (3, 15,  'Charles Leclerc'),
    (4, 12,  'George Russell'),
    (5, 10,  'Nico Hulkenberg'),
    (6, 8,  'Lewis Hamilton'),
    (7, 6,  'Isack Hadjar'),
    (8, 4,  'Pierre Gasly'),
    (9, 2,  'Fernando Alonso'),
    (10, 1,  'Max Verstappen')
) AS x(position, points, driver_name)
JOIN drivers d ON d.name = x.driver_name
JOIN seasons s ON s.year = 2025
JOIN races r   ON r.season_id = s.id AND r.name = 'Spain GP'
JOIN race_sessions sess ON sess.race_id = r.id AND sess.session_type = 'RACE'
JOIN driver_team_memberships m ON m.driver_id = d.id AND m.season_id = s.id
ON CONFLICT (driver_id, session_id) DO UPDATE
  SET position = EXCLUDED.position,
      points   = EXCLUDED.points;

-- ROUND 10: CANADA (RACE)
INSERT INTO session_results (driver_id, session_id, team_id, position, points)
SELECT d.id, sess.id, m.team_id, x.position, x.points
FROM (
  VALUES
    (1, 25,  'George Russell'),
    (2, 18,  'Max Verstappen'),
    (3, 15,  'Kimi Antonelli'),
    (4, 12,  'Oscar Piastri'),
    (5, 10,  'Charles Leclerc'),
    (6, 8,  'Lewis Hamilton'),
    (7, 6,  'Fernando Alonso'),
    (8, 4,  'Nico Hulkenberg'),
    (9, 2,  'Esteban Ocon'),
    (10, 1,  'Carlos Sainz')
) AS x(position, points, driver_name)
JOIN drivers d ON d.name = x.driver_name
JOIN seasons s ON s.year = 2025
JOIN races r   ON r.season_id = s.id AND r.name = 'Canada GP'
JOIN race_sessions sess ON sess.race_id = r.id AND sess.session_type = 'RACE'
JOIN driver_team_memberships m ON m.driver_id = d.id AND m.season_id = s.id
ON CONFLICT (driver_id, session_id) DO UPDATE
  SET position = EXCLUDED.position,
      points   = EXCLUDED.points;

-- ROUND 11: AUSTRIA (RACE)
INSERT INTO session_results (driver_id, session_id, team_id, position, points)
SELECT d.id, sess.id, m.team_id, x.position, x.points
FROM (
  VALUES
    (1, 25,  'Lando Norris'),
    (2, 18,  'Oscar Piastri'),
    (3, 15,  'Charles Leclerc'),
    (4, 12,  'Lewis Hamilton'),
    (5, 10,  'George Russell'),
    (6, 8,  'Liam Lawson'),
    (7, 6,  'Fernando Alonso'),
    (8, 4,  'Gabriel Bortoleto'),
    (9, 2,  'Nico Hulkenberg'),
    (10, 1,  'Esteban Ocon')
) AS x(position, points, driver_name)
JOIN drivers d ON d.name = x.driver_name
JOIN seasons s ON s.year = 2025
JOIN races r   ON r.season_id = s.id AND r.name = 'Austria GP'
JOIN race_sessions sess ON sess.race_id = r.id AND sess.session_type = 'RACE'
JOIN driver_team_memberships m ON m.driver_id = d.id AND m.season_id = s.id
ON CONFLICT (driver_id, session_id) DO UPDATE
  SET position = EXCLUDED.position,
      points   = EXCLUDED.points;

-- ROUND 12: United Kingdom (RACE)
INSERT INTO session_results (driver_id, session_id, team_id, position, points)
SELECT d.id, sess.id, m.team_id, x.position, x.points
FROM (
  VALUES
    (1, 25,  'Lando Norris'),
    (2, 18,  'Oscar Piastri'),
    (3, 15,  'Nico Hulkenberg'),
    (4, 12,  'Lewis Hamilton'),
    (5, 10,  'Max Verstappen'),
    (6, 8,  'Pierre Gasly'),
    (7, 6,  'Lance Stroll'),
    (8, 4,  'Alex Albon'),
    (9, 2,  'Fernando Alonso'),
    (10, 1,  'George Russell')
) AS x(position, points, driver_name)
JOIN drivers d ON d.name = x.driver_name
JOIN seasons s ON s.year = 2025
JOIN races r   ON r.season_id = s.id AND r.name = 'United Kingdom GP'
JOIN race_sessions sess ON sess.race_id = r.id AND sess.session_type = 'RACE'
JOIN driver_team_memberships m ON m.driver_id = d.id AND m.season_id = s.id
ON CONFLICT (driver_id, session_id) DO UPDATE
  SET position = EXCLUDED.position,
      points   = EXCLUDED.points;

-- ROUND 13: BELGIUM (SPRINT)
INSERT INTO session_results (driver_id, session_id, team_id, position, points)
SELECT d.id, sess.id, m.team_id, x.position, x.points
FROM (
  VALUES
    -- position, points, driver_name
    (1, 8, 'Max Verstappen'),
    (2, 7, 'Oscar Piastri'),
    (3, 6, 'Lando Norris'),
    (4, 5, 'Charles Leclerc'),
    (5, 4, 'Esteban Ocon'),
    (6, 3,  'Carlos Sainz'),
    (7, 2,  'Oliver Bearman'),
    (8, 1,  'Isack Hadjar')
) AS x(position, points, driver_name)
JOIN drivers d ON d.name = x.driver_name
JOIN seasons s ON s.year = 2025
JOIN races r   ON r.season_id = s.id AND r.name = 'Belgium GP'
JOIN race_sessions sess ON sess.race_id = r.id AND sess.session_type = 'SPRINT'
JOIN driver_team_memberships m ON m.driver_id = d.id AND m.season_id = s.id
ON CONFLICT (driver_id, session_id) DO UPDATE
  SET position = EXCLUDED.position,
      points   = EXCLUDED.points;

-- ROUND 13: BELGIUM (RACE)
INSERT INTO session_results (driver_id, session_id, team_id, position, points)
SELECT d.id, sess.id, m.team_id, x.position, x.points
FROM (
  VALUES
    (1, 25,  'Oscar Piastri'),
    (2, 18,  'Lando Norris'),
    (3, 15,  'Charles Leclerc'),
    (4, 12,  'Max Verstappen'),
    (5, 10,  'George Russell'),
    (6, 8,  'Alex Albon'),
    (7, 6,  'Lewis Hamilton'),
    (8, 4,  'Liam Lawson'),
    (9, 2,  'Gabriel Bortoleto'),
    (10, 1,  'Pierre Gasly')
) AS x(position, points, driver_name)
JOIN drivers d ON d.name = x.driver_name
JOIN seasons s ON s.year = 2025
JOIN races r   ON r.season_id = s.id AND r.name = 'Belgium GP'
JOIN race_sessions sess ON sess.race_id = r.id AND sess.session_type = 'RACE'
JOIN driver_team_memberships m ON m.driver_id = d.id AND m.season_id = s.id
ON CONFLICT (driver_id, session_id) DO UPDATE
  SET position = EXCLUDED.position,
      points   = EXCLUDED.points;

-- ROUND 14: HUNGARY (RACE)
INSERT INTO session_results (driver_id, session_id, team_id, position, points)
SELECT d.id, sess.id, m.team_id, x.position, x.points
FROM (
  VALUES
    (1, 25,  'Lando Norris'),
    (2, 18,  'Oscar Piastri'),
    (3, 15,  'George Russell'),
    (4, 12,  'Charles Leclerc'),
    (5, 10,  'Fernando Alonso'),
    (6, 8,  'Gabriel Bortoleto'),
    (7, 6,  'Lance Stroll'),
    (8, 4,  'Liam Lawson'),
    (9, 2,  'Max Verstappen'),
    (10, 1,  'Kimi Antonelli')
) AS x(position, points, driver_name)
JOIN drivers d ON d.name = x.driver_name
JOIN seasons s ON s.year = 2025
JOIN races r   ON r.season_id = s.id AND r.name = 'Hungary GP'
JOIN race_sessions sess ON sess.race_id = r.id AND sess.session_type = 'RACE'
JOIN driver_team_memberships m ON m.driver_id = d.id AND m.season_id = s.id
ON CONFLICT (driver_id, session_id) DO UPDATE
  SET position = EXCLUDED.position,
      points   = EXCLUDED.points;

-- ROUND 15: NETHERLANDS (RACE)
INSERT INTO session_results (driver_id, session_id, team_id, position, points)
SELECT d.id, sess.id, m.team_id, x.position, x.points
FROM (
  VALUES
    (1, 25,  'Oscar Piastri'),
    (2, 18,  'Max Verstappen'),
    (3, 15,  'Isack Hadjar'),
    (4, 12,  'George Russell'),
    (5, 10,  'Alex Albon'),
    (6, 8,  'Oliver Bearman'),
    (7, 6,  'Lance Stroll'),
    (8, 4,  'Fernando Alonso'),
    (9, 2,  'Yuki Tsunoda'),
    (10, 1,  'Esteban Ocon')
) AS x(position, points, driver_name)
JOIN drivers d ON d.name = x.driver_name
JOIN seasons s ON s.year = 2025
JOIN races r   ON r.season_id = s.id AND r.name = 'Netherlands GP'
JOIN race_sessions sess ON sess.race_id = r.id AND sess.session_type = 'RACE'
JOIN driver_team_memberships m ON m.driver_id = d.id AND m.season_id = s.id
ON CONFLICT (driver_id, session_id) DO UPDATE
  SET position = EXCLUDED.position,
      points   = EXCLUDED.points;

-- ROUND 16: ITALY (RACE)
INSERT INTO session_results (driver_id, session_id, team_id, position, points)
SELECT d.id, sess.id, m.team_id, x.position, x.points
FROM (
  VALUES
    (1, 25,  'Max Verstappen'),
    (2, 18,  'Lando Norris'),
    (3, 15,  'Oscar Piastri'),
    (4, 12,  'Charles Leclerc'),
    (5, 10,  'George Russell'),
    (6, 8,  'Lewis Hamilton'),
    (7, 6,  'Alex Albon'),
    (8, 4,  'Gabriel Bortoleto'),
    (9, 2,  'Kimi Antonelli'),
    (10, 1,  'Isack Hadjar')
) AS x(position, points, driver_name)
JOIN drivers d ON d.name = x.driver_name
JOIN seasons s ON s.year = 2025
JOIN races r   ON r.season_id = s.id AND r.name = 'Italy GP'
JOIN race_sessions sess ON sess.race_id = r.id AND sess.session_type = 'RACE'
JOIN driver_team_memberships m ON m.driver_id = d.id AND m.season_id = s.id
ON CONFLICT (driver_id, session_id) DO UPDATE
  SET position = EXCLUDED.position,
      points   = EXCLUDED.points;

-- ROUND 17: AZERBAIJAN (RACE)
INSERT INTO session_results (driver_id, session_id, team_id, position, points)
SELECT d.id, sess.id, m.team_id, x.position, x.points
FROM (
  VALUES
    (1, 25,  'Max Verstappen'),
    (2, 18,  'George Russell'),
    (3, 15,  'Carlos Sainz'),
    (4, 12,  'Kimi Antonelli'),
    (5, 10,  'Liam Lawson'),
    (6, 8,  'Yuki Tsunoda'),
    (7, 6,  'Lando Norris'),
    (8, 4,  'Lewis Hamilton'),
    (9, 2,  'Charles Leclerc'),
    (10, 1,  'Isack Hadjar')
) AS x(position, points, driver_name)
JOIN drivers d ON d.name = x.driver_name
JOIN seasons s ON s.year = 2025
JOIN races r   ON r.season_id = s.id AND r.name = 'Azerbaijan GP'
JOIN race_sessions sess ON sess.race_id = r.id AND sess.session_type = 'RACE'
JOIN driver_team_memberships m ON m.driver_id = d.id AND m.season_id = s.id
ON CONFLICT (driver_id, session_id) DO UPDATE
  SET position = EXCLUDED.position,
      points   = EXCLUDED.points;

-- ROUND 18: SINGAPORE (RACE)
INSERT INTO session_results (driver_id, session_id, team_id, position, points)
SELECT d.id, sess.id, m.team_id, x.position, x.points
FROM (
  VALUES
    (1, 25,  'George Russell'),
    (2, 18,  'Max Verstappen'),
    (3, 15,  'Lando Norris'),
    (4, 12,  'Oscar Piastri'),
    (5, 10,  'Kimi Antonelli'),
    (6, 8,  'Charles Leclerc'),
    (7, 6,  'Fernando Alonso'),
    (8, 4,  'Lewis Hamilton'),
    (9, 2,  'Oliver Bearman'),
    (10, 1,  'Carlos Sainz')
) AS x(position, points, driver_name)
JOIN drivers d ON d.name = x.driver_name
JOIN seasons s ON s.year = 2025
JOIN races r   ON r.season_id = s.id AND r.name = 'Singapore GP'
JOIN race_sessions sess ON sess.race_id = r.id AND sess.session_type = 'RACE'
JOIN driver_team_memberships m ON m.driver_id = d.id AND m.season_id = s.id
ON CONFLICT (driver_id, session_id) DO UPDATE
  SET position = EXCLUDED.position,
      points   = EXCLUDED.points;

-- ROUND 20: MEXICO (RACE)
INSERT INTO session_results (driver_id, session_id, team_id, position, points)
SELECT d.id, sess.id, m.team_id, x.position, x.points
FROM (
  VALUES
    (1, 25,  'Lando Norris'),
    (2, 18,  'Charles Leclerc'),
    (3, 15,  'Max Verstappen'),
    (4, 12,  'Oliver Bearman'),
    (5, 10,  'Oscar Piastri'),
    (6, 8,  'Kimi Antonelli'),
    (7, 6,  'George Russell'),
    (8, 4,  'Lewis Hamilton'),
    (9, 2,  'Esteban Ocon'),
    (10, 1,  'Gabriel Bortoleto')
) AS x(position, points, driver_name)
JOIN drivers d ON d.name = x.driver_name
JOIN seasons s ON s.year = 2025
JOIN races r   ON r.season_id = s.id AND r.name = 'Mexico GP'
JOIN race_sessions sess ON sess.race_id = r.id AND sess.session_type = 'RACE'
JOIN driver_team_memberships m ON m.driver_id = d.id AND m.season_id = s.id
ON CONFLICT (driver_id, session_id) DO UPDATE
  SET position = EXCLUDED.position,
      points   = EXCLUDED.points;

-- ROUND 21: BRAZIL(RACE)
INSERT INTO session_results (driver_id, session_id, team_id, position, points)
SELECT d.id, sess.id, m.team_id, x.position, x.points
FROM (
  VALUES
    (1, 25,  'Lando Norris'),
    (2, 18,  'Kimi Antonelli'),
    (3, 15,  'Max Verstappen'),
    (4, 12,  'George Russell'),
    (5, 10,  'Oscar Piastri'),
    (6, 8,  'Oliver Bearman'),
    (7, 6,  'Liam Lawson'),
    (8, 4,  'Isack Hadjar'),
    (9, 2,  'Nico Hulkenberg'),
    (10, 1,  'Pierre Gasly')
) AS x(position, points, driver_name)
JOIN drivers d ON d.name = x.driver_name
JOIN seasons s ON s.year = 2025
JOIN races r   ON r.season_id = s.id AND r.name = 'Brazil GP'
JOIN race_sessions sess ON sess.race_id = r.id AND sess.session_type = 'RACE'
JOIN driver_team_memberships m ON m.driver_id = d.id AND m.season_id = s.id
ON CONFLICT (driver_id, session_id) DO UPDATE
  SET position = EXCLUDED.position,
      points   = EXCLUDED.points;

-- ROUND 22: LAS VEGAS (RACE)
INSERT INTO session_results (driver_id, session_id, team_id, position, points)
SELECT d.id, sess.id, m.team_id, x.position, x.points
FROM (
  VALUES
    (1, 25,  'Max Verstappen'),
    (2, 18,  'George Russell'),
    (3, 15,  'Kimi Antonelli'),
    (4, 12,  'Charles Leclerc'),
    (5, 10,  'Carlos Sainz'),
    (6, 8,  'Isack Hadjar'),
    (7, 6,  'Nico Hulkenberg'),
    (8, 4,  'Lewis Hamilton'),
    (9, 2,  'Esteban Ocon'),
    (10, 1,  'Oliver Bearman')
) AS x(position, points, driver_name)
JOIN drivers d ON d.name = x.driver_name
JOIN seasons s ON s.year = 2025
JOIN races r   ON r.season_id = s.id AND r.name = 'Las Vegas GP'
JOIN race_sessions sess ON sess.race_id = r.id AND sess.session_type = 'RACE'
JOIN driver_team_memberships m ON m.driver_id = d.id AND m.season_id = s.id
ON CONFLICT (driver_id, session_id) DO UPDATE
  SET position = EXCLUDED.position,
      points   = EXCLUDED.points;

-- ROUND 23: QATAR (RACE)
INSERT INTO session_results (driver_id, session_id, team_id, position, points)
SELECT d.id, sess.id, m.team_id, x.position, x.points
FROM (
  VALUES
    (1, 25,  'Max Verstappen'),
    (2, 18,  'Oscar Piastri'),
    (3, 15,  'Carlos Sainz'),
    (4, 12,  'Lando Norris'),
    (5, 10,  'Kimi Antonelli'),
    (6, 8,  'George Russell'),
    (7, 6,  'Fernando Alonso'),
    (8, 4,  'Charles Leclerc'),
    (9, 2,  'Liam Lawson'),
    (10, 1,  'Yuki Tsunoda')
) AS x(position, points, driver_name)
JOIN drivers d ON d.name = x.driver_name
JOIN seasons s ON s.year = 2025
JOIN races r   ON r.season_id = s.id AND r.name = 'Qatar GP'
JOIN race_sessions sess ON sess.race_id = r.id AND sess.session_type = 'RACE'
JOIN driver_team_memberships m ON m.driver_id = d.id AND m.season_id = s.id
ON CONFLICT (driver_id, session_id) DO UPDATE
  SET position = EXCLUDED.position,
      points   = EXCLUDED.points;