/**
 * DDL and DML statements for SQLite.  This data will eventually be moved to HDFS using Sqoop.
 * Author: Andrew Jarombek
 * Date: 3/28/2020
 */

-- Two tables, representing runs and core workouts I've done recently.

DROP TABLE IF EXISTS runs;
DROP TABLE IF EXISTS core;

CREATE TABLE runs (
    id INTEGER PRIMARY KEY,
    name VARCHAR(127) NOT NULL,
    location VARCHAR(127) NOT NULL,
    date VARCHAR(127) NOT NULL,
    miles DOUBLE NOT NULL,
    minutes INTEGER,
    seconds INTEGER,
    pace VARCHAR(31),
    description VARCHAR(255)
);

CREATE TABLE core (
    id INTEGER PRIMARY KEY,
    date VARCHAR(127) NOT NULL,
    pushups INTEGER NOT NULL,
    minutes INTEGER NOT NULL
);

-- Data for the 'runs' and 'core' table.

INSERT INTO runs (
    id, name, location, date, miles, minutes, seconds, pace
) VALUES (
    1, 'North Mianus School Run', 'Riverside - CT', '2020-03-19', 3.83, NULL, NULL, NULL
);

INSERT INTO runs (
    id, name, location, date, miles, minutes, seconds, pace, description
) VALUES (
    2, 'Central Park Exploratory Run', 'New York - NY', '2020-03-20', 5.95, 36, 47, '6:11',
    'Too fast, not used to the road being so flat.'
);

INSERT INTO runs (
    id, name, location, date, miles, minutes, seconds, pace
) VALUES (
    3, 'Central Park Full Loop', 'New York - NY', '2020-03-21', 6.65, 44, 46, '6:48'
);

INSERT INTO runs (
    id, name, location, date, miles, minutes, seconds, pace
) VALUES (
    4, 'Central Park Half Loop', 'New York - NY', '2020-03-22', 3.87, 24, 46, '6:33'
);

INSERT INTO runs (
    id, name, location, date, miles, minutes, seconds, pace
) VALUES (
    5, 'Central Park Half Loop', 'New York - NY', '2020-03-23', 3.87, NULL, NULL, NULL
);

INSERT INTO runs (
    id, name, location, date, miles, minutes, seconds, pace
) VALUES (
    6, 'Central Park Half Loop', 'New York - NY', '2020-03-24', 3.82, 24, 55, '6:31'
);

INSERT INTO runs (
    id, name, location, date, miles, minutes, seconds, pace
) VALUES (
    7, 'Central Park Half Loop', 'New York - NY', '2020-03-25', 3.77, 26, 49, '7:06'
);

INSERT INTO runs (
    id, name, location, date, miles, minutes, seconds, pace
) VALUES (
    8, 'Central Park Half Loop', 'New York - NY', '2020-03-26', 3.74, 24, 05, '6:27'
);

INSERT INTO runs (
    id, name, location, date, miles, minutes, seconds, pace
) VALUES (
    9, 'Central Park Half Loop', 'New York - NY', '2020-03-27', 3.93, 25, 53, '6:34'
);

INSERT INTO runs (
    id, name, location, date, miles, minutes, seconds, pace, description
) VALUES (
    10, 'Central Park Full Loop', 'New York - NY', '2020-03-28', 6.18, 41, 31, '6:18', 'Quiet in the rain.'
);

INSERT INTO runs (
    id, name, location, date, miles, minutes, seconds, pace
) VALUES (
    11, 'Central Park South + Reservoir Half Loop', 'New York - NY', '2020-03-29', 4.79, NULL, NULL, NULL
);

INSERT INTO runs (
    id, name, location, date, miles, minutes, seconds, pace
) VALUES (
    12, 'Central Park South + Reservoir Half Loop', 'New York - NY', '2020-03-30', 4.79, 32, 41, '6:50'
);

INSERT INTO runs (
    id, name, location, date, miles, minutes, seconds, pace
) VALUES (
    13, 'Central Park South + Reservoir Half-Loop', 'New York - NY', '2020-03-31', 4.71, 33, 24, '7:05'
);

INSERT INTO runs (
    id, name, location, date, miles, minutes, seconds, pace
) VALUES (
    14, 'Central Park South + Reservoir Half Loop', 'New York - NY', '2020-04-01', 4.72, 31, 28, '6:40'
);

INSERT INTO runs (
    id, name, location, date, miles, minutes, seconds, pace
) VALUES (
    15, 'Central Park South + Reservoir Half Loop', 'New York - NY', '2020-04-02', 4.72, NULL, NULL, NULL
);

INSERT INTO runs (
    id, name, location, date, miles, minutes, seconds, pace
) VALUES (
    16, 'Central Park South + Reservoir Half Loop', 'New York - NY', '2020-04-03', 4.76, 32, 15, '6:46'
);

INSERT INTO runs (
    id, name, location, date, miles, minutes, seconds, pace
) VALUES (
    17, 'Central Park South + Reservoir Half Loop', 'New York - NY', '2020-04-04', 4.80, 31, 43, '6:36'
);

INSERT INTO runs (
    id, name, location, date, miles, minutes, seconds, pace
) VALUES (
    18, 'Central Park South + Reservoir Full Loop', 'New York - NY', '2020-04-05', 6.00, 40, 17, '6:42'
);

INSERT INTO core (id, date, pushups, minutes) VALUES (1, '2020-03-19', 0, 0);
INSERT INTO core (id, date, pushups, minutes) VALUES (2, '2020-03-20', 5, 0);
INSERT INTO core (id, date, pushups, minutes) VALUES (3, '2020-03-21', 10, 0);
INSERT INTO core (id, date, pushups, minutes) VALUES (4, '2020-03-22', 30, 6);
INSERT INTO core (id, date, pushups, minutes) VALUES (5, '2020-03-23', 20, 6);
INSERT INTO core (id, date, pushups, minutes) VALUES (6, '2020-03-24', 20, 7);
INSERT INTO core (id, date, pushups, minutes) VALUES (7, '2020-03-25', 20, 6);
INSERT INTO core (id, date, pushups, minutes) VALUES (8, '2020-03-26', 20, 6);
INSERT INTO core (id, date, pushups, minutes) VALUES (9, '2020-03-27', 20, 6);
INSERT INTO core (id, date, pushups, minutes) VALUES (10, '2020-03-28', 30, 8);
INSERT INTO core (id, date, pushups, minutes) VALUES (11, '2020-03-29', 30, 8);
INSERT INTO core (id, date, pushups, minutes) VALUES (12, '2020-03-30', 30, 8);
INSERT INTO core (id, date, pushups, minutes) VALUES (13, '2020-03-31', 20, 8);
INSERT INTO core (id, date, pushups, minutes) VALUES (14, '2020-04-01', 35, 8);
INSERT INTO core (id, date, pushups, minutes) VALUES (15, '2020-04-02', 20, 8);
INSERT INTO core (id, date, pushups, minutes) VALUES (16, '2020-04-03', 20, 8);
INSERT INTO core (id, date, pushups, minutes) VALUES (17, '2020-04-04', 20, 8);
INSERT INTO core (id, date, pushups, minutes) VALUES (18, '2020-04-05', 20, 8);

-- Give all permissions to the user Sqoop runs from
GRANT ALL ON core TO 'root'@'ip-{MySQLAddressDashed}.ec2.internal';
GRANT ALL ON runs TO 'root'@'ip-{MySQLAddressDashed}.ec2.internal';
GRANT ALL ON core TO 'yarn'@'ip-{YARNAddress}.ec2.internal';
GRANT ALL ON runs TO 'yarn'@'ip-{YARNAddress}.ec2.internal';
