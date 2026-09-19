-- Drop existing tables to ensure clean execution
DROP TABLE BOOK CASCADE CONSTRAINTS;
DROP TABLE LUGGAGE CASCADE CONSTRAINTS;
DROP TABLE FLIGHT CASCADE CONSTRAINTS;
DROP TABLE FLIGHT_ATTENDANT CASCADE CONSTRAINTS;
DROP TABLE PILOT CASCADE CONSTRAINTS;
DROP TABLE EMPLOYEE CASCADE CONSTRAINTS;
DROP TABLE AIRPLANE CASCADE CONSTRAINTS;
DROP TABLE AIRPORT CASCADE CONSTRAINTS;

-- 1. Airport Table
CREATE TABLE AIRPORT (
    Airport_ID   INTEGER      NOT NULL PRIMARY KEY,
    AirportName  VARCHAR2(50) NOT NULL,
    Country      VARCHAR2(30),
    City         VARCHAR2(30)
);

-- 2. Airplane Table
CREATE TABLE AIRPLANE (
    Airplane_ID  INTEGER      NOT NULL PRIMARY KEY,
    Capacity     INTEGER,
    Model        VARCHAR2(50),
    Manufacturer VARCHAR2(50)
);

-- 3. Employee Superclass Table
CREATE TABLE EMPLOYEE (
    Employee_ID  INTEGER      NOT NULL PRIMARY KEY,
    Address      VARCHAR2(50),
    Gender       CHAR(1),
    FName        VARCHAR2(20),
    MName        VARCHAR2(20),
    LName        VARCHAR2(20),
    Salary       INTEGER,
    BDate        DATE,
    Airport_ID   INTEGER,
    CONSTRAINT fk_emp_airport FOREIGN KEY (Airport_ID) REFERENCES AIRPORT(Airport_ID)
);

-- 4. Pilot Subclass Table
CREATE TABLE PILOT (
    E_ID           INTEGER      NOT NULL PRIMARY KEY,
    PRank          VARCHAR2(20),
    License_Number VARCHAR2(20) NOT NULL,
    CONSTRAINT fk_pilot_employee FOREIGN KEY (E_ID) REFERENCES EMPLOYEE(Employee_ID)
);

-- 5. Flight Attendant Subclass Table
CREATE TABLE FLIGHT_ATTENDANT (
    E_ID    INTEGER      NOT NULL PRIMARY KEY,
    FA_Rank VARCHAR2(20),
    CONSTRAINT fk_fa_employee FOREIGN KEY (E_ID) REFERENCES EMPLOYEE(Employee_ID)
);

-- 6. Passenger Table
CREATE TABLE PASSENGER (
    Passenger_ID INTEGER       NOT NULL PRIMARY KEY,
    P_FName      VARCHAR2(20),
    P_MName      VARCHAR2(20),
    P_LName      VARCHAR2(20),
    PhoneNo      VARCHAR2(15),
    BDate        DATE,
    P_Email      VARCHAR2(100) NOT NULL
);

-- 7. Flight Table
CREATE TABLE FLIGHT (
    Flight_ID   INTEGER      NOT NULL PRIMARY KEY,
    Duration    VARCHAR2(20),
    ALocation   VARCHAR2(30),
    ADate       DATE,
    ATime       VARCHAR2(6),
    DLocation   VARCHAR2(30),
    DDate       DATE,
    DTime       VARCHAR2(6),
    Airplane_ID INTEGER,
    Airport_ID  INTEGER,
    CONSTRAINT fk_flight_airplane FOREIGN KEY (Airplane_ID) REFERENCES AIRPLANE(Airplane_ID),
    CONSTRAINT fk_flight_airport FOREIGN KEY (Airport_ID) REFERENCES AIRPORT(Airport_ID)
);

-- 8. Luggage Table
CREATE TABLE LUGGAGE (
    Luggage_ID   INTEGER       NOT NULL PRIMARY KEY,
    Weight       DECIMAL(4,2),
    Passenger_ID INTEGER       NOT NULL,
    CONSTRAINT fk_luggage_passenger FOREIGN KEY (Passenger_ID) REFERENCES PASSENGER(Passenger_ID)
);

-- 9. Book Association Table
CREATE TABLE BOOK (
    Flight_ID    INTEGER      NOT NULL,
    Passenger_ID INTEGER      NOT NULL,
    Price        INTEGER      NOT NULL,
    Seat_Number  VARCHAR2(5),
    CONSTRAINT pk_book PRIMARY KEY (Flight_ID, Passenger_ID),
    CONSTRAINT fk_book_flight FOREIGN KEY (Flight_ID) REFERENCES FLIGHT(Flight_ID),
    CONSTRAINT fk_book_passenger FOREIGN KEY (Passenger_ID) REFERENCES PASSENGER(Passenger_ID)
);
