
--Task 1
CREATE TABLE weather (
	id int PRIMARY KEY NOT NULL,
	recordDate date UNIQUE NOT NULL,
	temperature float NOT NULL

);

SELECT * FROM weather;

--Task 2
CREATE TABLE weather_details (
	Desc_id int PRIMARY KEY NOT NULL,
	W_Description varchar(100) NOT NULL,
	tempID int NOT NULL FOREIGN KEY  REFERENCES weather(id) ON DELETE CASCADE

);

SELECT * FROM weather_details;

--Task 3
EXEC sp_rename 'dbo.weather_details.tempID', 'temperatureID', 'COLUMN';

--task 4
INSERT INTO weather VALUES (1, '2022-11-10', 32);
INSERT INTO weather VALUES (2, '2022-11-11', 39);
INSERT INTO weather VALUES (3, '2022-11-12', 24);
INSERT INTO weather VALUES (4, '2022-11-13', 34);
INSERT INTO weather VALUES (5, '2021-11-10', 23);
INSERT INTO weather VALUES (6, '2021-11-11', 38);
INSERT INTO weather VALUES (7, '2021-11-12', 33);

INSERT INTO weather_details VALUES (1, 'Cold', 3);
INSERT INTO weather_details VALUES (2, 'Cold', 5);
INSERT INTO weather_details VALUES (3, 'Hot', 2);
INSERT INTO weather_details VALUES (4, 'Hot', 6);
INSERT INTO weather_details VALUES (5, 'Windy', 1);
INSERT INTO weather_details VALUES (6, 'Windy', 4);
INSERT INTO weather_details VALUES (7, 'Windy', 7);

SELECT * FROM weather;
SELECT * FROM weather_details;

--DROP TABLE weather_details;
--DROP TABLE weather;

--Task 5
SELECT * 
FROM weather
WHERE temperature > 35 AND YEAR(recordDate) = 2022;

--Task 6
SELECT weather_details.W_Description, weather.temperature, weather.recordDate
FROM weather_details
INNER JOIN weather ON weather.id = weather_details.temperatureID
WHERE YEAR(recordDate) = 2021;

--Task 7
UPDATE weather
SET temperature = (1.8 * temperature) + 32;

--Task 8
UPDATE weather_details
SET W_Description = 'Stormy'
WHERE W_Description = 'Windy';

--Task 9
DELETE FROM weather
WHERE recordDate > CURRENT_TIMESTAMP;

--Task 10
DELETE FROM  weather;

--Task 11
TRUNCATE TABLE weather_details;

--Task 12
DROP TABLE weather_details;
DROP TABLE weather;