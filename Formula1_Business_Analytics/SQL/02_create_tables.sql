CREATE TABLE seasons (

    year SMALLINT PRIMARY KEY,

    url VARCHAR(255)

);

CREATE TABLE circuits (

    circuitId INT PRIMARY KEY,

    circuitRef VARCHAR(60),

    name VARCHAR(120),

    location VARCHAR(80),

    country VARCHAR(80),

    lat DECIMAL(10,6),

    lng DECIMAL(10,6),

    alt SMALLINT,

    url VARCHAR(255)

);

CREATE TABLE constructors (

    constructorId INT PRIMARY KEY,

    constructorRef VARCHAR(60),

    name VARCHAR(100),

    nationality VARCHAR(60),

    url VARCHAR(255)

);

CREATE TABLE drivers (

    driverId INT PRIMARY KEY,

    driverRef VARCHAR(60),

    number SMALLINT,

    code CHAR(3),

    forename VARCHAR(60),

    surname VARCHAR(60),

    dob DATE,

    nationality VARCHAR(60),

    url VARCHAR(255)

);

CREATE TABLE status (

    statusId INT PRIMARY KEY,

    status VARCHAR(80)

);

CREATE TABLE races (

    raceId INT PRIMARY KEY,

    year SMALLINT,

    round TINYINT,

    circuitId INT,

    name VARCHAR(150),

    date DATE,

    time TIME,

    url VARCHAR(255),

    fp1_date DATE,

    fp1_time TIME,

    fp2_date DATE,

    fp2_time TIME,

    fp3_date DATE,

    fp3_time TIME,

    quali_date DATE,

    quali_time TIME,

    sprint_date DATE,

    sprint_time TIME

);

CREATE TABLE results (

    resultId INT PRIMARY KEY,

    raceId INT,

    driverId INT,

    constructorId INT,

    number SMALLINT,

    grid SMALLINT,

    position SMALLINT,

    positionText VARCHAR(20),

    positionOrder SMALLINT,

    points DECIMAL(6,2),

    laps SMALLINT,

    time VARCHAR(30),

    milliseconds BIGINT,

    fastestLap SMALLINT,

    fastestLapRank SMALLINT,

    fastestLapTime VARCHAR(30),

    fastestLapSpeed DECIMAL(8,3),

    statusId INT

);

CREATE TABLE driver_standings (

    driverStandingsId INT PRIMARY KEY,

    raceId INT,

    driverId INT,

    points DECIMAL(6,2),

    position SMALLINT,

    positionText VARCHAR(20),

    wins SMALLINT

);

CREATE TABLE constructor_standings (

    constructorStandingsId INT PRIMARY KEY,

    raceId INT,

    constructorId INT,

    points DECIMAL(6,2),

    position SMALLINT,

    positionText VARCHAR(20),

    wins SMALLINT

);

CREATE TABLE qualifying (

    qualifyId INT PRIMARY KEY,

    raceId INT,

    driverId INT,

    constructorId INT,

    number SMALLINT,

    position SMALLINT,

    q1 VARCHAR(20),

    q2 VARCHAR(20),

    q3 VARCHAR(20)

);

CREATE TABLE lap_times (

    raceId INT,

    driverId INT,

    lap SMALLINT,

    position SMALLINT,

    time VARCHAR(20),

    milliseconds INT,

    PRIMARY KEY(raceId,driverId,lap)

);

CREATE TABLE pit_stops (

    raceId INT,

    driverId INT,

    stop SMALLINT,

    lap SMALLINT,

    time TIME,

    duration VARCHAR(20),

    milliseconds INT,

    PRIMARY KEY(raceId,driverId,stop)

);

CREATE TABLE sprint_results (

    resultId INT PRIMARY KEY,

    raceId INT,

    driverId INT,

    constructorId INT,

    number SMALLINT,

    grid SMALLINT,

    position SMALLINT,

    positionText VARCHAR(20),

    positionOrder SMALLINT,

    points DECIMAL(6,2),

    laps SMALLINT,

    time VARCHAR(30),

    milliseconds BIGINT,

    fastestLap SMALLINT,

    fastestLapTime VARCHAR(30),

    statusId INT

);

CREATE TABLE constructor_results (

    constructorResultsId INT PRIMARY KEY,

    raceId INT,

    constructorId INT,

    points DECIMAL(6,2),

    status VARCHAR(40)

);