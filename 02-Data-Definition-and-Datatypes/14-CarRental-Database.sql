-- CREATE DATABASE CarRental
-- GO
-- USE CarRental

CREATE TABLE Categories (
	Id int NOT NULL IDENTITY, 
	Category nvarchar(200) NOT NULL UNIQUE, 
	DailyRate money CHECK (DailyRate >= 0), 
	WeeklyRate money CHECK (WeeklyRate >= 0), 
	MonthlyRate money CHECK (MonthlyRate >= 0), 
	WeekendRate money CHECK (WeekendRate >= 0),
	PRIMARY KEY (Id)
)

CREATE TABLE Cars (
	Id int NOT NULL IDENTITY, 
	PlateNumber varchar(10) NOT NULL UNIQUE, 
	Make varchar(200) NOT NULL, 
	Model varchar(200) NOT NULL, 
	CarYear int NOT NULL CHECK (CarYear >= 1900), 
	CategoryId int NOT NULL, 
	Doors int NOT NULL CHECK (Doors > 0 AND Doors <= 5), 
	Picture varbinary(max),
	Condition nvarchar(200),
	Available bit,
	PRIMARY KEY (Id),
	FOREIGN KEY (CategoryId) REFERENCES Categories (Id)
)

CREATE TABLE Employees (
	Id int NOT NULL IDENTITY,
	FirstName nvarchar(200) NOT NULL, 
	LastName nvarchar(200) NOT NULL, 
	Title nvarchar(200) NOT NULL, 
	Notes nvarchar(max),
	PRIMARY KEY (Id)
)

CREATE TABLE Customers (
	Id int NOT NULL IDENTITY,
	DriverLicenceNumber varchar(200) NOT NULL, 
	FullName nvarchar(200) NOT NULL, 
	Address nvarchar(max) NOT NULL, 
	City nvarchar(200) NOT NULL, 
	ZIPCode varchar(50) NOT NULL, 
	Notes nvarchar(max),
	PRIMARY KEY (Id)
)

CREATE TABLE RentalOrders(
	Id int NOT NULL IDENTITY,
	EmployeeId int NOT NULL,
	CustomerId int NOT NULL,
	CarId int NOT NULL,
	CarCondition nvarchar(200) NOT NULL,
	TankLevel float NOT NULL,
	KilometrageStart float NOT NULL,
	KilometrageEnd float NOT NULL,
	TotalKilometrage float NOT NULL,
	StartDate date NOT NULL,
	EndDate date NOT NULL,
	TotalDays int NOT NULL,
	RateApplied money NOT NULL,
	TaxRate money NOT NULL,
	OrderStatus nvarchar(200) NOT NULL,
	Notes nvarchar(max),
	PRIMARY KEY (Id),
	FOREIGN KEY (EmployeeId) REFERENCES Employees (Id),
	FOREIGN KEY (CustomerId) REFERENCES Customers (Id),
	FOREIGN KEY (CarId) REFERENCES Cars (Id),
	CHECK (TotalKilometrage = KilometrageEnd - KilometrageStart),
	CHECK (TotalDays = DATEDIFF(day, StartDate, EndDate) + 1)
)

INSERT INTO Categories (Category, DailyRate, WeeklyRate, MonthlyRate, WeekendRate)
VALUES
	('Economy', 15, 50, 1000, 40),
	('Standard', 80, 500, 2000, 200),
	('Premium', 100, NULL, NULL, NULL)

INSERT INTO Cars (PlateNumber, Make, Model, CarYear, CategoryId, Doors, Picture, Condition, Available)
VALUES
	('CA12345XB', 'Sedan', 'Renault', 2016, 1, 4, 0101010, 'Excellent', 1),
	('TT4444TT', 'SUV', 'VW', 2016, 1, 4, 111000, 'Outstanding', 1),
	('VV5555HH', 'Sedan', 'Mercedes', 2016, 3, 4, 01111, 'Excellent', 0)
	
INSERT INTO Employees (FirstName, LastName, Title)
VALUES
	('Tom', 'Barnes', 'Sales Representative'),
	('David', 'Jones', 'CEO'),
	('Eva', 'Michado', 'Software developer')

INSERT INTO Customers (DriverLicenceNumber, FullName, Address, City, ZIPCode, Notes)
VALUES
	('A111111', 'Angela MErkel', 'Willy-Brandt-Strasse 1', 'Berlin', '10557', 'New leader of the free world'),
	('B222222', 'Barack Obama', '1600 Pennsylvania Ave NW', 'Washington', 'DC 20500', 'Previous leader of the free world'),
	('C333333', 'Bill Clinton', '555 Bloomberg Avenue', 'New York', 'NY 1000', NULL)

INSERT INTO RentalOrders (EmployeeId, CustomerId, CarId, CarCondition, TankLevel, KilometrageStart, KilometrageEnd, TotalKilometrage, StartDate, EndDate, TotalDays, RateApplied, TaxRate, OrderStatus, Notes)
VALUES
	(1, 1, 1, 'Excellent', 100, 30100, 30200.5, 100.5, '2017-01-22', '2017-01-22', 1, 15, 0.20, 'Rented', NULL),
	(2, 2, 2, 'Returned with damages', 100, 30100, 30250.5, 150.5, '2017-01-20', '2017-01-22', 3, 80, 0.20, 'Pending', 'TBD'),
	(3, 3, 3, 'Excellent', 100, 30000, 30200.5, 200.5, '2017-01-21', '2017-01-22', 2, 110, 0.20, 'Closed', NULL)