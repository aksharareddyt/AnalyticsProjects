USE Formula1Analytics;
-- 1. Top 10 drivers by career points
WITH DriverPoints AS
(
    SELECT
        d.driverId,
        CONCAT(d.forename,' ',d.surname) AS Driver,
        SUM(r.points) AS CareerPoints
    FROM drivers d
    JOIN results r
        ON d.driverId = r.driverId
    GROUP BY d.driverId, Driver
)
SELECT *
FROM DriverPoints
ORDER BY CareerPoints DESC
LIMIT 10;

-- 2. Drivers above average career points
WITH DriverPoints AS
(
    SELECT
        d.driverId,
        CONCAT(d.forename,' ',d.surname) AS Driver,
        SUM(r.points) AS CareerPoints
    FROM drivers d
    JOIN results r
        ON d.driverId = r.driverId
    GROUP BY d.driverId, Driver
)
SELECT *
FROM DriverPoints
WHERE CareerPoints >
(
    SELECT AVG(CareerPoints)
    FROM DriverPoints
);

-- 3. COnstructor performance
WITH ConstructorPerformance AS
(
    SELECT
        c.constructorId,
        c.name,
        SUM(r.points) AS TotalPoints,
        COUNT(*) AS TotalRaces
    FROM constructors c
    JOIN results r
        ON c.constructorId = r.constructorId
    GROUP BY c.constructorId, c.name
)
SELECT *
FROM ConstructorPerformance
ORDER BY TotalPoints DESC;

-- 4. Best driver from each nationality
WITH DriverPoints AS
(
    SELECT
        d.driverId,
        d.nationality,
        CONCAT(d.forename,' ',d.surname) AS Driver,
        SUM(r.points) AS CareerPoints
    FROM drivers d
    JOIN results r
        ON d.driverId = r.driverId
    GROUP BY
        d.driverId,
        d.nationality,
        Driver
),
RankedDrivers AS
(
    SELECT *,
           RANK() OVER
           (
               PARTITION BY nationality
               ORDER BY CareerPoints DESC
           ) AS Ranking
    FROM DriverPoints
)
SELECT *
FROM RankedDrivers
WHERE Ranking = 1;

-- 5. Seasons with above average number of races
WITH SeasonSummary AS
(
    SELECT
        year,
        COUNT(*) AS TotalRaces
    FROM races
    GROUP BY year
)
SELECT *
FROM SeasonSummary
WHERE TotalRaces >
(
    SELECT AVG(TotalRaces)
    FROM SeasonSummary
);

-- 6. Drivers with more than 10 wins
WITH DriverWins AS
(
    SELECT
        d.driverId,
        CONCAT(d.forename,' ',d.surname) AS Driver,
        COUNT(*) AS Wins
    FROM drivers d
    JOIN results r
        ON d.driverId = r.driverId
    WHERE r.positionOrder = 1
    GROUP BY d.driverId, Driver
)
SELECT *
FROM DriverWins
WHERE Wins > 10
ORDER BY Wins DESC;

-- 7. Circuit race count
WITH CircuitSummary AS
(
    SELECT
        c.name,
        c.country,
        COUNT(r.raceId) AS RaceCount
    FROM circuits c
    LEFT JOIN races r
        ON c.circuitId = r.circuitId
    GROUP BY
        c.circuitId,
        c.name,
        c.country
)
SELECT *
FROM CircuitSummary
ORDER BY RaceCount DESC;

-- 8. Constructor above average points
WITH ConstructorPoints AS
(
    SELECT
        c.name,
        SUM(r.points) AS TotalPoints
    FROM constructors c
    JOIN results r
        ON c.constructorId = r.constructorId
    GROUP BY c.constructorId, c.name
)
SELECT *
FROM ConstructorPoints
WHERE TotalPoints >
(
    SELECT AVG(TotalPoints)
    FROM ConstructorPoints
)
ORDER BY TotalPoints DESC;