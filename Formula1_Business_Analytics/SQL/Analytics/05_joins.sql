/* DRIVERS & CONSTRUCTORS
1. List every driver with their constructor and race */
SELECT
    d.forename,
    d.surname,
    c.name AS constructor_name,
    r.name AS race_name,
    r.year
FROM results res
INNER JOIN drivers d
    ON res.driverId = d.driverId
INNER JOIN constructors c
    ON res.constructorId = c.constructorId
INNER JOIN races r
    ON res.raceId = r.raceId
LIMIT 30;

-- 2. Which constructor have entered most races?
SELECT
    c.name,
    COUNT(*) AS races_entered
FROM results res
INNER JOIN constructors c
ON res.constructorId = c.constructorId
GROUP BY c.name
ORDER BY races_entered DESC;

-- 3. Which drivers have entered most races?
SELECT
    d.forename,
    d.surname,
    COUNT(*) AS races
FROM results res
JOIN drivers d
ON res.driverId=d.driverId
GROUP BY d.driverId,d.forename,d.surname
ORDER BY races DESC
LIMIT 20;

/* DRIVER PERFORMANCE
1. Top 20 drivers by career points */
SELECT
    d.forename,
    d.surname,
    ROUND(SUM(res.points),2) AS career_points
FROM results res
JOIN drivers d
ON res.driverId=d.driverId
GROUP BY d.driverId,d.forename,d.surname
ORDER BY career_points DESC
LIMIT 20;

-- 2. Top 20 race winners
SELECT
    d.forename,
    d.surname,
    COUNT(*) AS wins
FROM results res
JOIN drivers d
ON res.driverId=d.driverId
WHERE positionOrder=1
GROUP BY d.driverId,d.forename,d.surname
ORDER BY wins DESC
LIMIT 20;

-- 3. Drivers with the most podiums
SELECT
    d.forename,
    d.surname,
    COUNT(*) AS podiums
FROM results res
JOIN drivers d
ON res.driverId=d.driverId
WHERE positionOrder<=3
GROUP BY d.driverId,d.forename,d.surname
ORDER BY podiums DESC
LIMIT 20;

/* CONSTRUCTORS PERFORMANCE
1. Constructors with most wins */
SELECT
    c.name,
    COUNT(*) AS wins
FROM results res
JOIN constructors c
ON res.constructorId=c.constructorId
WHERE positionOrder=1
GROUP BY c.constructorId,c.name
ORDER BY wins DESC;

-- 2. Constructors with highest career points
SELECT
    c.name,
    ROUND(SUM(res.points),2) AS total_points
FROM results res
JOIN constructors c
ON res.constructorId=c.constructorId
GROUP BY c.constructorId,c.name
ORDER BY total_points DESC;

/* CIRCUIT ANALYSIS
1. Which circuits have hosted most races */
SELECT
    cir.name,
    cir.country,
    COUNT(*) AS total_races
FROM races r
JOIN circuits cir
ON r.circuitId=cir.circuitId
GROUP BY cir.circuitId,cir.name,cir.country
ORDER BY total_races DESC;

-- 2. Top countries hosting races
SELECT
    cir.country,
    COUNT(*) AS races
FROM races r
JOIN circuits cir
ON r.circuitId=cir.circuitId
GROUP BY cir.country
ORDER BY races DESC;

/* NATIONALITY ANALYSIS
1. Which nationality has scored most points? */
SELECT
    d.nationality,
    ROUND(SUM(res.points),2) AS total_points
FROM results res
JOIN drivers d
ON res.driverId=d.driverId
GROUP BY d.nationality
ORDER BY total_points DESC;

-- 2. Which nationality has won the most races?
SELECT
    d.nationality,
    COUNT(*) AS wins
FROM results res
JOIN drivers d
ON res.driverId=d.driverId
WHERE positionOrder=1
GROUP BY d.nationality
ORDER BY wins DESC;

/* SEASON ANALYSIS
1. How many races were held each season? */
SELECT
    r.year,
    COUNT(*) AS races
FROM races r
GROUP BY r.year

-- 2. How many points were awarded each season?
SELECT
    r.year,
    ROUND(SUM(res.points),2) AS points_awarded
FROM results res
JOIN races r
ON res.raceId=r.raceId
GROUP BY r.year
ORDER BY r.year;