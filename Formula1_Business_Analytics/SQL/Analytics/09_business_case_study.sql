-- 1. Who are the greatest formula 1 drivers
SELECT
    CONCAT(d.forename,' ',d.surname) AS Driver,
    SUM(r.points) AS CareerPoints,
    COUNT(CASE WHEN r.positionOrder = 1 THEN 1 END) AS Wins,
    COUNT(CASE WHEN r.positionOrder <= 3 THEN 1 END) AS Podiums
FROM results r
JOIN drivers d
ON r.driverId = d.driverId
GROUP BY d.driverId, Driver
ORDER BY CareerPoints DESC
LIMIT 20;
-- Identifying the most successful drivers based on career achievements.

-- 2. Which constructors dominate formula 1?
SELECT
    c.name,
    SUM(r.points) AS TotalPoints,
    COUNT(CASE WHEN r.positionOrder = 1 THEN 1 END) AS Wins
FROM results r
JOIN constructors c
ON r.constructorId = c.constructorId
GROUP BY c.constructorId, c.name
ORDER BY TotalPoints DESC;
-- Identifying the dominating constructor with the help of total points and race wins

-- 3. Which countries produce strongest drivers?
SELECT
    d.nationality,
    SUM(r.points) AS TotalPoints,
    COUNT(CASE WHEN r.positionOrder = 1 THEN 1 END) AS Wins
FROM results r
JOIN drivers d
ON r.driverId = d.driverId
GROUP BY d.nationality
ORDER BY TotalPoints DESC;
-- Identifying the nationality of strongest drivers

-- 4. Which circuit hosts most races?
SELECT
    c.name,
    c.country,
    COUNT(*) AS TotalRaces
FROM races r
JOIN circuits c
ON r.circuitId = c.circuitId
GROUP BY c.circuitId, c.name, c.country
ORDER BY TotalRaces DESC;

-- 5. Which seasons awarded most championship points?
SELECT
    ra.year,
    SUM(r.points) AS TotalPoints
FROM results r
JOIN races ra
ON r.raceId = ra.raceId
GROUP BY ra.year
ORDER BY TotalPoints DESC;

-- 6. Which drivers consistently start well
SELECT
    CONCAT(d.forename,' ',d.surname) AS Driver,
    ROUND(AVG(r.grid),2) AS AverageGridPosition
FROM results r
JOIN drivers d
ON r.driverId = d.driverId
GROUP BY d.driverId, Driver
HAVING COUNT(*) >= 50
ORDER BY AverageGridPosition;
-- Idnetifying consistent drivers with average grid position

-- 7. Which drivers gain the most positions during races?
SELECT
    CONCAT(d.forename,' ',d.surname) AS Driver,
    ROUND(AVG(r.grid - r.positionOrder),2) AS AveragePositionsGained
FROM results r
JOIN drivers d
ON r.driverId = d.driverId
WHERE r.grid > 0
GROUP BY d.driverId, Driver
HAVING COUNT(*) >= 50
ORDER BY AveragePositionsGained DESC;

-- 8. Which circuits have the highest retirement rates?
SELECT
    c.name,
    COUNT(*) AS TotalRetirements
FROM results r
JOIN races ra
ON r.raceId = ra.raceId
JOIN circuits c
ON ra.circuitId = c.circuitId
WHERE r.positionText = 'R'
GROUP BY c.circuitId, c.name
ORDER BY TotalRetirements DESC;

-- 9. Which constructors have the highest average race per race?
SELECT
    c.name,
    ROUND(AVG(r.points),2) AS AveragePoints
FROM results r
JOIN constructors c
ON r.constructorId = c.constructorId
GROUP BY c.constructorId, c.name
ORDER BY AveragePoints DESC;

-- 10. How has formula 1 expanded over time?
SELECT
    year,
    COUNT(*) AS NumberOfRaces
FROM races
GROUP BY year
ORDER BY year;
-- Identifying the popularity of formula 1 by number of races each year