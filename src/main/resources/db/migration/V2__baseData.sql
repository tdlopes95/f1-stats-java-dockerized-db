-- ===== Seasons =====
INSERT INTO seasons (year) VALUES (2025), (2026);

-- ===== Teams =====
INSERT INTO teams (name) VALUES
  ('Red Bull Racing'), ('Mercedes'), ('McLaren'), ('Ferrari'), ('Alpine'),
  ('Aston Martin'), ('Williams'), ('Audi'), ('Cadillac'), ('Racing Bulls'), ('Haas');

-- ===== Drivers =====
INSERT INTO drivers (name) VALUES
  ('Max Verstappen'), ('Lewis Hamilton'), ('Lando Norris'), ('Pierre Gasly'),
  ('Franco Colapinto'), ('Fernando Alonso'), ('Lance Stroll'), ('Nico Hulkenberg'),
  ('Gabriel Bortoleto'), ('Sergio Perez'), ('Valtteri Bottas'), ('Charles Leclerc'),
  ('Esteban Ocon'), ('Oliver Bearman'), ('Oscar Piastri'), ('George Russell'),
  ('Kimi Antonelli'), ('Liam Lawson'), ('Arvid Lindblad'), ('Isack Hadjar'),
  ('Yuki Tsunoda'), ('Carlos Sainz'), ('Alex Albon');

-- ======================================================================
-- Driver team memberships (SEASON 2025)
-- ======================================================================
INSERT INTO driver_team_memberships (driver_id, team_id, season_id)
SELECT d.id, t.id, s.id
FROM drivers d
JOIN teams t ON (d.name, t.name) IN (
  ('Max Verstappen','Red Bull Racing'),
  ('Yuki Tsunoda',  'Red Bull Racing'),
  ('Kimi Antonelli','Mercedes'),
  ('George Russell','Mercedes'),
  ('Lando Norris',  'McLaren'),
  ('Oscar Piastri', 'McLaren'),
  ('Lewis Hamilton','Ferrari'),
  ('Charles Leclerc','Ferrari'),
  ('Pierre Gasly',  'Alpine'),
  ('Franco Colapinto','Alpine'),
  ('Fernando Alonso','Aston Martin'),
  ('Lance Stroll',  'Aston Martin'),
  ('Nico Hulkenberg','Audi'),
  ('Gabriel Bortoleto','Audi'),
  ('Esteban Ocon',  'Haas'),
  ('Oliver Bearman','Haas'),
  ('Liam Lawson',   'Racing Bulls'),
  ('Isack Hadjar',  'Racing Bulls'),
  ('Carlos Sainz',  'Williams'),
  ('Alex Albon',    'Williams')
)
CROSS JOIN (SELECT id FROM seasons WHERE year = 2025) s;

-- ======================================================================
-- Driver team memberships (SEASON 2026)
-- ======================================================================
INSERT INTO driver_team_memberships (driver_id, team_id, season_id)
SELECT d.id, t.id, s.id
FROM drivers d
JOIN teams t ON (d.name, t.name) IN (
  ('Max Verstappen','Red Bull Racing'),
  ('Isack Hadjar',  'Red Bull Racing'),
  ('Kimi Antonelli','Mercedes'),
  ('George Russell','Mercedes'),
  ('Lando Norris',  'McLaren'),
  ('Oscar Piastri', 'McLaren'),
  ('Lewis Hamilton','Ferrari'),
  ('Charles Leclerc','Ferrari'),
  ('Pierre Gasly',  'Alpine'),
  ('Franco Colapinto','Alpine'),
  ('Fernando Alonso','Aston Martin'),
  ('Lance Stroll',  'Aston Martin'),
  ('Nico Hulkenberg','Audi'),
  ('Gabriel Bortoleto','Audi'),
  ('Esteban Ocon',  'Haas'),
  ('Oliver Bearman','Haas'),
  ('Liam Lawson',   'Racing Bulls'),
  ('Arvid Lindblad','Racing Bulls'),
  ('Carlos Sainz',  'Williams'),
  ('Alex Albon',    'Williams'),
  ('Sergio Perez',  'Cadillac'),
  ('Valtteri Bottas','Cadillac')
)
CROSS JOIN (SELECT id FROM seasons WHERE year = 2026) s;

-- ======================================================================
-- RACES (SEASON 2025)
-- ======================================================================
INSERT INTO races (season_id, name, race_date, round)
SELECT s.id, 'Australia GP',      '2025-03-16',  1  FROM seasons s WHERE year=2025;
INSERT INTO races (season_id, name, race_date, round)
SELECT s.id, 'China GP',          '2025-03-23',  2  FROM seasons s WHERE year=2025;
INSERT INTO races (season_id, name, race_date, round)
SELECT s.id, 'Japan GP',          '2025-04-06',  3  FROM seasons s WHERE year=2025;
INSERT INTO races (season_id, name, race_date, round)
SELECT s.id, 'Bahrain GP',        '2025-04-13',  4  FROM seasons s WHERE year=2025;
INSERT INTO races (season_id, name, race_date, round)
SELECT s.id, 'Saudi Arabia GP',   '2025-04-20',  5  FROM seasons s WHERE year=2025;
INSERT INTO races (season_id, name, race_date, round)
SELECT s.id, 'Miami GP',          '2025-05-04',  6  FROM seasons s WHERE year=2025;
INSERT INTO races (season_id, name, race_date, round)
SELECT s.id, 'Emilia Romagna GP', '2025-05-18',  7  FROM seasons s WHERE year=2025;
INSERT INTO races (season_id, name, race_date, round)
SELECT s.id, 'Monaco GP',         '2025-05-25',  8  FROM seasons s WHERE year=2025;
INSERT INTO races (season_id, name, race_date, round)
SELECT s.id, 'Spain GP',          '2025-06-01',  9  FROM seasons s WHERE year=2025;
INSERT INTO races (season_id, name, race_date, round)
SELECT s.id, 'Canada GP',         '2025-06-15', 10  FROM seasons s WHERE year=2025;
INSERT INTO races (season_id, name, race_date, round)
SELECT s.id, 'Austria GP',        '2025-06-29', 11  FROM seasons s WHERE year=2025;
INSERT INTO races (season_id, name, race_date, round)
SELECT s.id, 'United Kingdom GP', '2025-07-06', 12  FROM seasons s WHERE year=2025;
INSERT INTO races (season_id, name, race_date, round)
SELECT s.id, 'Belgium GP',        '2025-07-27', 13  FROM seasons s WHERE year=2025;
INSERT INTO races (season_id, name, race_date, round)
SELECT s.id, 'Hungary GP',        '2025-08-03', 14  FROM seasons s WHERE year=2025;
INSERT INTO races (season_id, name, race_date, round)
SELECT s.id, 'Netherlands GP',    '2025-08-31', 15  FROM seasons s WHERE year=2025;
INSERT INTO races (season_id, name, race_date, round)
SELECT s.id, 'Italy GP',          '2025-09-07', 16  FROM seasons s WHERE year=2025;
INSERT INTO races (season_id, name, race_date, round)
SELECT s.id, 'Azerbaijan GP',     '2025-09-21', 17  FROM seasons s WHERE year=2025;
INSERT INTO races (season_id, name, race_date, round)
SELECT s.id, 'Singapore GP',      '2025-10-05', 18  FROM seasons s WHERE year=2025;
INSERT INTO races (season_id, name, race_date, round)
SELECT s.id, 'USA GP',            '2025-10-19', 19  FROM seasons s WHERE year=2025;
INSERT INTO races (season_id, name, race_date, round)
SELECT s.id, 'Mexico GP',         '2025-10-26', 20  FROM seasons s WHERE year=2025;
INSERT INTO races (season_id, name, race_date, round)
SELECT s.id, 'Brazil GP',         '2025-11-09', 21  FROM seasons s WHERE year=2025;
INSERT INTO races (season_id, name, race_date, round)
SELECT s.id, 'Las Vegas GP',      '2025-11-22', 22  FROM seasons s WHERE year=2025;
INSERT INTO races (season_id, name, race_date, round)
SELECT s.id, 'Qatar GP',          '2025-11-30', 23  FROM seasons s WHERE year=2025;
INSERT INTO races (season_id, name, race_date, round)
SELECT s.id, 'Abu Dhabi GP',      '2025-12-07', 24  FROM seasons s WHERE year=2025;

-- ======================================================================
-- RACES (SEASON 2026)  -- dates fixed to 2026; round 16 is "Madrid GP"
-- ======================================================================
INSERT INTO races (season_id, name, race_date, round)
SELECT s.id, 'Australia GP',      '2026-03-08',  1 FROM seasons s WHERE year=2026;
INSERT INTO races (season_id, name, race_date, round)
SELECT s.id, 'China GP',          '2026-03-15',  2 FROM seasons s WHERE year=2026;
INSERT INTO races (season_id, name, race_date, round)
SELECT s.id, 'Japan GP',          '2026-03-29',  3 FROM seasons s WHERE year=2026;
INSERT INTO races (season_id, name, race_date, round)
SELECT s.id, 'Bahrain GP',        '2026-04-12',  4 FROM seasons s WHERE year=2026;
INSERT INTO races (season_id, name, race_date, round)
SELECT s.id, 'Saudi Arabia GP',   '2026-04-19',  5 FROM seasons s WHERE year=2026;
INSERT INTO races (season_id, name, race_date, round)
SELECT s.id, 'Miami GP',          '2026-05-03',  6 FROM seasons s WHERE year=2026;
INSERT INTO races (season_id, name, race_date, round)
SELECT s.id, 'Canada GP',         '2026-05-24',  7 FROM seasons s WHERE year=2026;
INSERT INTO races (season_id, name, race_date, round)
SELECT s.id, 'Monaco GP',         '2026-06-07',  8 FROM seasons s WHERE year=2026;
INSERT INTO races (season_id, name, race_date, round)
SELECT s.id, 'Spain GP',          '2026-06-14',  9 FROM seasons s WHERE year=2026;
INSERT INTO races (season_id, name, race_date, round)
SELECT s.id, 'Austria GP',        '2026-06-28', 10 FROM seasons s WHERE year=2026;
INSERT INTO races (season_id, name, race_date, round)
SELECT s.id, 'United Kingdom GP', '2026-07-05', 11 FROM seasons s WHERE year=2026;
INSERT INTO races (season_id, name, race_date, round)
SELECT s.id, 'Belgium GP',        '2026-07-19', 12 FROM seasons s WHERE year=2026;
INSERT INTO races (season_id, name, race_date, round)
SELECT s.id, 'Hungary GP',        '2026-07-26', 13 FROM seasons s WHERE year=2026;
INSERT INTO races (season_id, name, race_date, round)
SELECT s.id, 'Netherlands GP',    '2026-08-23', 14 FROM seasons s WHERE year=2026;
INSERT INTO races (season_id, name, race_date, round)
SELECT s.id, 'Italy GP',          '2026-09-06', 15 FROM seasons s WHERE year=2026;
INSERT INTO races (season_id, name, race_date, round)
SELECT s.id, 'Madrid GP',         '2026-09-13', 16 FROM seasons s WHERE year=2026; -- was duplicate Spain, now Madrid
INSERT INTO races (season_id, name, race_date, round)
SELECT s.id, 'Azerbaijan GP',     '2026-09-27', 17 FROM seasons s WHERE year=2026;
INSERT INTO races (season_id, name, race_date, round)
SELECT s.id, 'Singapore GP',      '2026-10-11', 18 FROM seasons s WHERE year=2026;
INSERT INTO races (season_id, name, race_date, round)
SELECT s.id, 'USA GP',            '2026-10-25', 19 FROM seasons s WHERE year=2026;
INSERT INTO races (season_id, name, race_date, round)
SELECT s.id, 'Mexico GP',         '2026-11-01', 20 FROM seasons s WHERE year=2026;
INSERT INTO races (season_id, name, race_date, round)
SELECT s.id, 'Brazil GP',         '2026-11-08', 21 FROM seasons s WHERE year=2026;
INSERT INTO races (season_id, name, race_date, round)
SELECT s.id, 'Las Vegas GP',      '2026-11-21', 22 FROM seasons s WHERE year=2026;
INSERT INTO races (season_id, name, race_date, round)
SELECT s.id, 'Qatar GP',          '2026-11-29', 23 FROM seasons s WHERE year=2026;
INSERT INTO races (season_id, name, race_date, round)
SELECT s.id, 'Abu Dhabi GP',      '2026-12-06', 24 FROM seasons s WHERE year=2026;

-- ======================================================================
-- Sessions (SEASON 2025 only)
-- ======================================================================

-- 1. Australia (RACE)
INSERT INTO race_sessions (race_id, session_type, session_no, session_date)
SELECT r.id, 'RACE', 1, r.race_date
FROM races r JOIN seasons s ON s.id = r.season_id AND s.year = 2025
WHERE r.name='Australia GP';

-- 2. China (SPRINT + RACE)
INSERT INTO race_sessions (race_id, session_type, session_no, session_date)
SELECT r.id, 'SPRINT', 1, r.race_date
FROM races r JOIN seasons s ON s.id = r.season_id AND s.year = 2025
WHERE r.name='China GP';
INSERT INTO race_sessions (race_id, session_type, session_no, session_date)
SELECT r.id, 'RACE', 1, r.race_date
FROM races r JOIN seasons s ON s.id = r.season_id AND s.year = 2025
WHERE r.name='China GP';

-- 3. Japan (RACE)
INSERT INTO race_sessions (race_id, session_type, session_no, session_date)
SELECT r.id, 'RACE', 1, r.race_date
FROM races r JOIN seasons s ON s.id = r.season_id AND s.year = 2025
WHERE r.name='Japan GP';

-- 4. Bahrain (RACE)
INSERT INTO race_sessions (race_id, session_type, session_no, session_date)
SELECT r.id, 'RACE', 1, r.race_date
FROM races r JOIN seasons s ON s.id = r.season_id AND s.year = 2025
WHERE r.name='Bahrain GP';

-- 5. Saudi Arabia (RACE)
INSERT INTO race_sessions (race_id, session_type, session_no, session_date)
SELECT r.id, 'RACE', 1, r.race_date
FROM races r JOIN seasons s ON s.id = r.season_id AND s.year = 2025
WHERE r.name='Saudi Arabia GP';

-- 6. Miami (SPRINT + RACE)
INSERT INTO race_sessions (race_id, session_type, session_no, session_date)
SELECT r.id, 'SPRINT', 1, r.race_date
FROM races r JOIN seasons s ON s.id = r.season_id AND s.year = 2025
WHERE r.name='Miami GP';
INSERT INTO race_sessions (race_id, session_type, session_no, session_date)
SELECT r.id, 'RACE', 1, r.race_date
FROM races r JOIN seasons s ON s.id = r.season_id AND s.year = 2025
WHERE r.name='Miami GP';

-- 7. Emilia-Romagna (RACE)
INSERT INTO race_sessions (race_id, session_type, session_no, session_date)
SELECT r.id, 'RACE', 1, r.race_date
FROM races r JOIN seasons s ON s.id = r.season_id AND s.year = 2025
WHERE r.name='Emilia Romagna GP';

-- 8. Monaco (RACE)
INSERT INTO race_sessions (race_id, session_type, session_no, session_date)
SELECT r.id, 'RACE', 1, r.race_date
FROM races r JOIN seasons s ON s.id = r.season_id AND s.year = 2025
WHERE r.name='Monaco GP';

-- 9. Spain (RACE)
INSERT INTO race_sessions (race_id, session_type, session_no, session_date)
SELECT r.id, 'RACE', 1, r.race_date
FROM races r JOIN seasons s ON s.id = r.season_id AND s.year = 2025
WHERE r.name='Spain GP';

-- 10. Canada (RACE)
INSERT INTO race_sessions (race_id, session_type, session_no, session_date)
SELECT r.id, 'RACE', 1, r.race_date
FROM races r JOIN seasons s ON s.id = r.season_id AND s.year = 2025
WHERE r.name='Canada GP';

-- 11. Austria (RACE)
INSERT INTO race_sessions (race_id, session_type, session_no, session_date)
SELECT r.id, 'RACE', 1, r.race_date
FROM races r JOIN seasons s ON s.id = r.season_id AND s.year = 2025
WHERE r.name='Austria GP';

-- 12. United Kingdom (RACE)
INSERT INTO race_sessions (race_id, session_type, session_no, session_date)
SELECT r.id, 'RACE', 1, r.race_date
FROM races r JOIN seasons s ON s.id = r.season_id AND s.year = 2025
WHERE r.name='United Kingdom GP';

-- 13. Belgium (SPRINT + RACE)
INSERT INTO race_sessions (race_id, session_type, session_no, session_date)
SELECT r.id, 'SPRINT', 1, r.race_date
FROM races r JOIN seasons s ON s.id = r.season_id AND s.year = 2025
WHERE r.name='Belgium GP';
INSERT INTO race_sessions (race_id, session_type, session_no, session_date)
SELECT r.id, 'RACE', 1, r.race_date
FROM races r JOIN seasons s ON s.id = r.season_id AND s.year = 2025
WHERE r.name='Belgium GP';

-- 14. Hungary (RACE)
INSERT INTO race_sessions (race_id, session_type, session_no, session_date)
SELECT r.id, 'RACE', 1, r.race_date
FROM races r JOIN seasons s ON s.id = r.season_id AND s.year = 2025
WHERE r.name='Hungary GP';

-- 15. Netherlands (RACE)
INSERT INTO race_sessions (race_id, session_type, session_no, session_date)
SELECT r.id, 'RACE', 1, r.race_date
FROM races r JOIN seasons s ON s.id = r.season_id AND s.year = 2025
WHERE r.name='Netherlands GP';

-- 16. Italy (RACE)
INSERT INTO race_sessions (race_id, session_type, session_no, session_date)
SELECT r.id, 'RACE', 1, r.race_date
FROM races r JOIN seasons s ON s.id = r.season_id AND s.year = 2025
WHERE r.name='Italy GP';

-- 17. Azerbaijan (RACE)
INSERT INTO race_sessions (race_id, session_type, session_no, session_date)
SELECT r.id, 'RACE', 1, r.race_date
FROM races r JOIN seasons s ON s.id = r.season_id AND s.year = 2025
WHERE r.name='Azerbaijan GP';

-- 18. Singapore (RACE)
INSERT INTO race_sessions (race_id, session_type, session_no, session_date)
SELECT r.id, 'RACE', 1, r.race_date
FROM races r JOIN seasons s ON s.id = r.season_id AND s.year = 2025
WHERE r.name='Singapore GP';

-- 19. USA (SPRINT + RACE)
INSERT INTO race_sessions (race_id, session_type, session_no, session_date)
SELECT r.id, 'SPRINT', 1, r.race_date
FROM races r JOIN seasons s ON s.id = r.season_id AND s.year = 2025
WHERE r.name='USA GP';
INSERT INTO race_sessions (race_id, session_type, session_no, session_date)
SELECT r.id, 'RACE', 1, r.race_date
FROM races r JOIN seasons s ON s.id = r.season_id AND s.year = 2025
WHERE r.name='USA GP';

-- 20. Mexico (RACE)
INSERT INTO race_sessions (race_id, session_type, session_no, session_date)
SELECT r.id, 'RACE', 1, r.race_date
FROM races r JOIN seasons s ON s.id = r.season_id AND s.year = 2025
WHERE r.name='Mexico GP';

-- 21. Brazil (SPRINT + RACE)
INSERT INTO race_sessions (race_id, session_type, session_no, session_date)
SELECT r.id, 'SPRINT', 1, r.race_date
FROM races r JOIN seasons s ON s.id = r.season_id AND s.year = 2025
WHERE r.name='Brazil GP';
INSERT INTO race_sessions (race_id, session_type, session_no, session_date)
SELECT r.id, 'RACE', 1, r.race_date
FROM races r JOIN seasons s ON s.id = r.season_id AND s.year = 2025
WHERE r.name='Brazil GP';

-- 22. Las Vegas (RACE)
INSERT INTO race_sessions (race_id, session_type, session_no, session_date)
SELECT r.id, 'RACE', 1, r.race_date
FROM races r JOIN seasons s ON s.id = r.season_id AND s.year = 2025
WHERE r.name='Las Vegas GP';

-- 23. Qatar (SPRINT + RACE)
INSERT INTO race_sessions (race_id, session_type, session_no, session_date)
SELECT r.id, 'SPRINT', 1, r.race_date
FROM races r JOIN seasons s ON s.id = r.season_id AND s.year = 2025
WHERE r.name='Qatar GP';
INSERT INTO race_sessions (race_id, session_type, session_no, session_date)
SELECT r.id, 'RACE', 1, r.race_date
FROM races r JOIN seasons s ON s.id = r.season_id AND s.year = 2025
WHERE r.name='Qatar GP';

-- 24. Abu Dhabi (RACE)
INSERT INTO race_sessions (race_id, session_type, session_no, session_date)
SELECT r.id, 'RACE', 1, r.race_date
FROM races r JOIN seasons s ON s.id = r.season_id AND s.year = 2025
WHERE r.name='Abu Dhabi GP';

-- ======================================================================
-- RESULTS (SEASON 2025)  -> joins compute the correct session_id each time
-- ======================================================================

-- ROUND 1: AUSTRALIA (RACE)
INSERT INTO session_results (driver_id, session_id, team_id, position, points)
SELECT d.id, rs.id, m.team_id, pos.p, pos.pts
FROM (VALUES
  (1,25,'Lando Norris'), (2,18,'Max Verstappen'), (3,15,'George Russell'),
  (4,12,'Kimi Antonelli'), (5,10,'Alex Albon'), (6,8,'Lance Stroll'),
  (7,6,'Nico Hulkenberg'), (8,4,'Charles Leclerc'), (9,2,'Oscar Piastri'),
  (10,1,'Lewis Hamilton')
) AS pos(p, pts, name)
JOIN drivers d  ON d.name = pos.name
JOIN seasons s  ON s.year = 2025
JOIN races r    ON r.season_id = s.id AND r.name = 'Australia GP'
JOIN race_sessions rs ON rs.race_id = r.id AND rs.session_type = 'RACE'
JOIN driver_team_memberships m ON m.driver_id = d.id AND m.season_id = s.id;

-- ROUND 2: CHINA (SPRINT)
INSERT INTO session_results (driver_id, session_id, team_id, position, points)
SELECT d.id, rs.id, m.team_id, pos.p, pos.pts
FROM (VALUES
  (1,8,'Lewis Hamilton'), (2,7,'Lando Norris'), (3,6,'Oscar Piastri'), (4,5,'George Russell'),
  (5,4,'Max Verstappen'), (6,3,'Kimi Antonelli'), (7,2,'Alex Albon'), (8,1,'Oliver Bearman')
) AS pos(p, pts, name)
JOIN drivers d  ON d.name = pos.name
JOIN seasons s  ON s.year = 2025
JOIN races r    ON r.season_id = s.id AND r.name = 'China GP'
JOIN race_sessions rs ON rs.race_id = r.id AND rs.session_type = 'SPRINT'
JOIN driver_team_memberships m ON m.driver_id = d.id AND m.season_id = s.id;

-- ROUND 2: CHINA (RACE)
INSERT INTO session_results (driver_id, session_id, team_id, position, points)
SELECT d.id, rs.id, m.team_id, pos.p, pos.pts
FROM (VALUES
  (1,25,'Oscar Piastri'), (2,18,'Lando Norris'), (3,15,'George Russell'), (4,12,'Max Verstappen'), (5,10,'Esteban Ocon'),
  (6,8,'Kimi Antonelli'), (7,6,'Alex Albon'), (8,4,'Oliver Bearman'), (9,2,'Lance Stroll'), (10,1,'Carlos Sainz')
) AS pos(p, pts, name)
JOIN drivers d  ON d.name = pos.name
JOIN seasons s  ON s.year = 2025
JOIN races r    ON r.season_id = s.id AND r.name = 'China GP'
JOIN race_sessions rs ON rs.race_id = r.id AND rs.session_type = 'RACE'
JOIN driver_team_memberships m ON m.driver_id = d.id AND m.season_id = s.id;

-- ROUND 6: MIAMI (SPRINT)
INSERT INTO session_results (driver_id, session_id, team_id, position, points)
SELECT d.id, rs.id, m.team_id, pos.p, pos.pts
FROM (VALUES
  (1,8,'Lando Norris'), (2,7,'Oscar Piastri'), (3,6,'Lewis Hamilton'), (4,5,'George Russell'),
  (5,4,'Max Verstappen'), (6,3,'Charles Leclerc'), (7,2,'Kimi Antonelli'), (8,1,'Alex Albon')
) AS pos(p, pts, name)
JOIN drivers d  ON d.name = pos.name
JOIN seasons s  ON s.year = 2025
JOIN races r    ON r.season_id = s.id AND r.name = 'Miami GP'
JOIN race_sessions rs ON rs.race_id = r.id AND rs.session_type = 'SPRINT'
JOIN driver_team_memberships m ON m.driver_id = d.id AND m.season_id = s.id;

-- ROUND 6: MIAMI (RACE)
INSERT INTO session_results (driver_id, session_id, team_id, position, points)
SELECT d.id, rs.id, m.team_id, pos.p, pos.pts
FROM (VALUES
  (1,25,'Oscar Piastri'), (2,18,'Lando Norris'), (3,15,'George Russell'), (4,12,'Max Verstappen'), (5,10,'Alex Albon'),
  (6,8,'Kimi Antonelli'), (7,6,'Charles Leclerc'), (8,4,'Lewis Hamilton'), (9,2,'Carlos Sainz'), (10,1,'Yuki Tsunoda')
) AS pos(p, pts, name)
JOIN drivers d  ON d.name = pos.name
JOIN seasons s  ON s.year = 2025
JOIN races r    ON r.season_id = s.id AND r.name = 'Miami GP'
JOIN race_sessions rs ON rs.race_id = r.id AND rs.session_type = 'RACE'
JOIN driver_team_memberships m ON m.driver_id = d.id AND m.season_id = s.id;

-- ROUND 19: USA / Austin (SPRINT)
INSERT INTO session_results (driver_id, session_id, team_id, position, points)
SELECT d.id, rs.id, m.team_id, pos.p, pos.pts
FROM (VALUES
  (1,8,'Max Verstappen'), (2,7,'George Russell'), (3,6,'Carlos Sainz'), (4,5,'Lewis Hamilton'),
  (5,4,'Charles Leclerc'), (6,3,'Alex Albon'), (7,2,'Yuki Tsunoda'), (8,1,'Kimi Antonelli')
) AS pos(p, pts, name)
JOIN drivers d  ON d.name = pos.name
JOIN seasons s  ON s.year = 2025
JOIN races r    ON r.season_id = s.id AND r.name = 'USA GP'
JOIN race_sessions rs ON rs.race_id = r.id AND rs.session_type = 'SPRINT'
JOIN driver_team_memberships m ON m.driver_id = d.id AND m.season_id = s.id;

-- ROUND 19: USA / Austin (RACE)
INSERT INTO session_results (driver_id, session_id, team_id, position, points)
SELECT d.id, rs.id, m.team_id, pos.p, pos.pts
FROM (VALUES
  (1,25,'Max Verstappen'), (2,18,'Lando Norris'), (3,15,'Charles Leclerc'), (4,12,'Lewis Hamilton'), (5,10,'Oscar Piastri'),
  (6,8,'George Russell'), (7,6,'Yuki Tsunoda'), (8,4,'Nico Hulkenberg'), (9,2,'Oliver Bearman'), (10,1,'Fernando Alonso')
) AS pos(p, pts, name)
JOIN drivers d  ON d.name = pos.name
JOIN seasons s  ON s.year = 2025
JOIN races r    ON r.season_id = s.id AND r.name = 'USA GP'
JOIN race_sessions rs ON rs.race_id = r.id AND rs.session_type = 'RACE'
JOIN driver_team_memberships m ON m.driver_id = d.id AND m.season_id = s.id;

-- ROUND 21: BRAZIL (SPRINT)
INSERT INTO session_results (driver_id, session_id, team_id, position, points)
SELECT d.id, rs.id, m.team_id, pos.p, pos.pts
FROM (VALUES
  (1,8,'Lando Norris'), (2,7,'Kimi Antonelli'), (3,6,'George Russell'), (4,5,'Max Verstappen'),
  (5,4,'Charles Leclerc'), (6,3,'Fernando Alonso'), (7,2,'Lewis Hamilton'), (8,1,'Pierre Gasly')
) AS pos(p, pts, name)
JOIN drivers d  ON d.name = pos.name
JOIN seasons s  ON s.year = 2025
JOIN races r    ON r.season_id = s.id AND r.name = 'Brazil GP'
JOIN race_sessions rs ON rs.race_id = r.id AND rs.session_type = 'SPRINT'
JOIN driver_team_memberships m ON m.driver_id = d.id AND m.season_id = s.id;

-- ROUND 23: QATAR (SPRINT)
INSERT INTO session_results (driver_id, session_id, team_id, position, points)
SELECT d.id, rs.id, m.team_id, pos.p, pos.pts
FROM (VALUES
  (1,8,'Oscar Piastri'), (2,7,'George Russell'), (3,6,'Lando Norris'), (4,5,'Max Verstappen'),
  (5,4,'Yuki Tsunoda'), (6,3,'Kimi Antonelli'), (7,2,'Fernando Alonso'), (8,1,'Carlos Sainz')
) AS pos(p, pts, name)
JOIN drivers d  ON d.name = pos.name
JOIN seasons s  ON s.year = 2025
JOIN races r    ON r.season_id = s.id AND r.name = 'Qatar GP'
JOIN race_sessions rs ON rs.race_id = r.id AND rs.session_type = 'SPRINT'
JOIN driver_team_memberships m ON m.driver_id = d.id AND m.season_id = s.id;

-- ROUND 24: ABU DHABI (RACE)
INSERT INTO session_results (driver_id, session_id, team_id, position, points)
SELECT d.id, rs.id, m.team_id, pos.p, pos.pts
FROM (VALUES
  (1,25,'Max Verstappen'), (2,18,'Oscar Piastri'), (3,15,'Lando Norris'), (4,12,'Charles Leclerc'), (5,10,'George Russell'),
  (6,8,'Fernando Alonso'), (7,6,'Esteban Ocon'), (8,4,'Lewis Hamilton'), (9,2,'Nico Hulkenberg'), (10,1,'Lance Stroll')
) AS pos(p, pts, name)
JOIN drivers d  ON d.name = pos.name
JOIN seasons s  ON s.year = 2025
JOIN races r    ON r.season_id = s.id AND r.name = 'Abu Dhabi GP'
JOIN race_sessions rs ON rs.race_id = r.id AND rs.session_type = 'RACE'
JOIN driver_team_memberships m ON m.driver_id = d.id AND m.season_id = s.id;