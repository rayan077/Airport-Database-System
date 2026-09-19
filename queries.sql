-- 1. Updates
UPDATE BOOK 
SET Seat_Number = '15A' 
WHERE Passenger_ID = 201;

UPDATE FLIGHT_ATTENDANT 
SET FA_Rank = 'Senior' 
WHERE E_ID = 303;

-- 2. Deletes
DELETE FROM FLIGHT 
WHERE ALocation = 'Dubai';

DELETE FROM AIRPLANE 
WHERE Model = 'A350';

-- 3. Simple Selects
SELECT Employee_ID, Salary FROM EMPLOYEE;
SELECT AirportName, Country FROM AIRPORT;

-- 4. Nested Queries
SELECT Luggage_ID, Weight 
FROM LUGGAGE 
WHERE Passenger_ID IN (
    SELECT Passenger_ID FROM LUGGAGE WHERE Passenger_ID = 202
);

SELECT Duration, ALocation, ADate, DLocation 
FROM FLIGHT 
WHERE Flight_ID IN (
    SELECT Flight_ID FROM FLIGHT WHERE Flight_ID = 403
);

-- 5. Join Queries
SELECT E.Address, E.Gender, E.BDate 
FROM EMPLOYEE E 
JOIN FLIGHT_ATTENDANT FA ON E.Employee_ID = FA.E_ID 
WHERE FA.FA_Rank = 'Senior';

SELECT F.Flight_ID, F.DLocation, F.ALocation, A.Model, A.Manufacturer 
FROM FLIGHT F 
JOIN AIRPLANE A ON F.Airplane_ID = A.Airplane_ID 
WHERE F.Flight_ID = 404;

-- 6. Aggregate & Group By Queries
SELECT PRank, COUNT(*) AS EmployeeCount 
FROM PILOT 
WHERE PRank = 'Captain' 
GROUP BY PRank;

SELECT Airport_ID, COUNT(*) AS AirportEmployee 
FROM EMPLOYEE 
WHERE Airport_ID = 3 
GROUP BY Airport_ID;

-- 7. Views
CREATE OR REPLACE VIEW Boeing_Airplanes AS 
SELECT Model, Capacity 
FROM AIRPLANE 
WHERE Manufacturer = 'Boeing';

CREATE OR REPLACE VIEW Flight_Info AS 
SELECT DLocation, DDate, DTime, Duration 
FROM FLIGHT 
WHERE DLocation IN ('New York', 'Tokyo');
