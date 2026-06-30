USE Formula1Analytics;
-- 1. Driver race results
CREATE OR REPLACE VIEW vw_driver_results AS
SELECT
    r.resultId,
    ra.year,
    ra.name AS race_name,
    d.driverId,
    CONCAT(d.forename,' ',d.surname) AS driver,
    c.name AS constructor,
    r.grid,
    r.positionOrder,
    r.points,
    r.fastestLap,
    r.fastestLapTime
FROM results r
JOIN drivers d
ON r.driverId=d.driverId
JOIN constructors c
ON r.constructorId=c.constructorId
JOIN races ra
ON r.raceId=ra.raceId;
-- TEsting
SELECT *
FROM vw_driver_results
LIMIT 20;

-- 2. COnstructor performance
CREATE OR REPLACE VIEW vw_constructor_results AS
SELECT
    c.name,
    COUNT(*) AS races,
    SUM(r.points) AS total_points,
    AVG(r.points) AS average_points
FROM results r
JOIN constructors c
ON r.constructorId=c.constructorId
GROUP BY c.constructorId,c.name;
-- Testing
SELECT *
FROM vw_constructor_results
ORDER BY total_points DESC;

-- 3. Driver career statistics
CREATE OR REPLACE VIEW vw_driver_statistics AS
SELECT
    d.driverId,
    CONCAT(d.forename,' ',d.surname) AS driver,
    COUNT(*) AS races,
    SUM(r.points) AS career_points,
    SUM(CASE WHEN positionOrder=1 THEN 1 ELSE 0 END) AS wins,
    SUM(CASE WHEN positionOrder<=3 THEN 1 ELSE 0 END) AS podiums
FROM results r
JOIN drivers d
ON r.driverId=d.driverId
GROUP BY
d.driverId,
driver;
-- Testing
SELECT *
FROM vw_driver_statistics
ORDER BY career_points DESC;

-- 4. Circuit statistics
CREATE OR REPLACE VIEW vw_circuit_statistics AS
SELECT
    c.name,
    c.country,
    COUNT(r.raceId) AS races_hosted
FROM circuits c
LEFT JOIN races r
ON c.circuitId=r.circuitId
GROUP BY
c.circuitId,
c.name,
c.country;
-- Testing
SELECT *
FROM vw_circuit_statistics
ORDER BY races_hosted DESC;

-- 5. Season summary
CREATE OR REPLACE VIEW vw_season_summary AS
SELECT
    year,
    COUNT(*) AS races
FROM races
GROUP BY year;
-- Testing
SELECT *
FROM vw_season_summary;