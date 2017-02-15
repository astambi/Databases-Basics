CREATE DATABASE AMS
GO
USE AMS
GO

CREATE TABLE Towns(
  TownID int,
  TownName varchar(30) NOT NULL,
  CONSTRAINT PK_Towns PRIMARY KEY (TownId)
)

CREATE TABLE Airports(
  AirportID int,
  AirportName varchar(50) NOT NULL,
  TownID int NOT NULL,
  CONSTRAINT PK_Aiports PRIMARY KEY (AirportID),
  CONSTRAINT FK_Aiports_Towns FOREIGN KEY (TownId) REFERENCES Towns(TownID)
)

CREATE TABLE Airlines(
  AirlineID int,
  AirlineName varchar(30) NOT NULL,
  Nationality varchar(30) NOT NULL,
  Rating int DEFAULT (0), --CHECK (Rating >= 0)
  CONSTRAINT PK_Airlines PRIMARY KEY (AirlineID)
)

CREATE TABLE Customers(
  CustomerID int,
  FirstName varchar(20) NOT NULL,
  LastName varchar(20) NOT NULL,
  DateOfBirth date NOT NULL,
  Gender varchar(1) NOT NULL CHECK (Gender IN ('M', 'F')), -- varchar?
  HomeTownID int NOT NULL,
  CONSTRAINT PK_Customers PRIMARY KEY (CustomerID),
  CONSTRAINT FK_Customers_Towns FOREIGN KEY (HomeTownID) REFERENCES Towns(TownID)
)

-- submit only Flights & Tickets in Judge!
CREATE TABLE Flights(
  FlightID int,
  DepartureTime datetime NOT NULL,
  ArrivalTime datetime NOT NULL,
  Status varchar(9) NOT NULL CHECK (Status IN ('Departing', 'Delayed', 'Arrived', 'Cancelled')),
  OriginAirportID int NOT NULL,
  DestinationAirportID int NOT NULL,
  AirlineID int NOT NULL,
  CONSTRAINT PK_Flights PRIMARY KEY (FlightID),
  CONSTRAINT FK_Flights_Airports_Origin FOREIGN KEY (OriginAirportID) REFERENCES Airports(AirportID),
  CONSTRAINT FK_Flights_Airports_Dest FOREIGN KEY (DestinationAirportID) REFERENCES Airports(AirportID),
  CONSTRAINT FK_Flights_AirlineID FOREIGN KEY (AirlineID) REFERENCES Airlines(AirlineID)
)

CREATE TABLE Tickets(
  TicketID int,
  Price numeric(8,2) NOT NULL,
  Class varchar(6) NOT NULL CHECK(Class IN ('First', 'Second', 'Third')),
  Seat varchar(5) NOT NULL,
  CustomerID int NOT NULL,
  FlightID int NOT NULL,
  CONSTRAINT PK_Tickets PRIMARY KEY (TicketID),
  CONSTRAINT FK_Tickets_Customers FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
  CONSTRAINT FK_Tickets_Flights FOREIGN KEY (FlightID) REFERENCES Flights(FlightID)
)