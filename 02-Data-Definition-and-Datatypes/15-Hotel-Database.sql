-- CREATE DATABASE Hotel
-- GO
-- USE Hotel

CREATE TABLE Employees (
	Id int IDENTITY,
	FirstName nvarchar(200) NOT NULL, 
	LastName nvarchar(200) NOT NULL, 
	Title nvarchar(200) NOT NULL, 
	Notes nvarchar(max),
	PRIMARY KEY (Id)
)

CREATE TABLE Customers (
	AccountNumber int IDENTITY,
	FirstName nvarchar(200) NOT NULL, 
	LastName nvarchar(200) NOT NULL, 
	PhoneNumber bigint NOT NULL,
	EmergencyName nvarchar(200),
	EmergencyNumber bigint,
	Notes nvarchar(max),
	PRIMARY KEY (AccountNumber),
	CHECK (PhoneNumber > 0)
)

CREATE TABLE RoomStatus (
	RoomStatus nvarchar(200) NOT NULL UNIQUE, 
	Notes nvarchar(max),
	PRIMARY KEY (RoomStatus)
)

CREATE TABLE RoomTypes (
	RoomType nvarchar(200) NOT NULL UNIQUE, 
	Notes nvarchar(max),
	PRIMARY KEY (RoomType)
)

CREATE TABLE BedTypes (
	BedType nvarchar(200) NOT NULL UNIQUE, 
	Notes nvarchar(max),
	PRIMARY KEY (BedType)
)

CREATE TABLE Rooms (
	RoomNumber int IDENTITY,
	RoomType nvarchar(200) NOT NULL,
	BedType nvarchar(200) NOT NULL,
	Rate money NOT NULL,
	RoomStatus nvarchar(200) NOT NULL,
	Note nvarchar(max),
	PRIMARY KEY (RoomNumber),
	FOREIGN KEY (RoomType) REFERENCES RoomTypes (RoomType),
	FOREIGN KEY (BedType) REFERENCES BedTypes (BedType),
	FOREIGN KEY (RoomStatus) REFERENCES RoomStatus (RoomStatus),
	CHECK (Rate >= 0)	
)

CREATE TABLE Payments (
	Id int IDENTITY, 
	EmployeeId int NOT NULL, 
	PaymentDate date NOT NULL, 
	AccountNumber int NOT NULL, 
	FirstDateOccupied date NOT NULL, 
	LastDateOccupied date NOT NULL, 
	TotalDays int NOT NULL, 
	AmountCharged money NOT NULL, 
	TaxRate money NOT NULL, 
	TaxAmount money NOT NULL, 
	PaymentTotal money NOT NULL, 
	Notes nvarchar(max),
	PRIMARY KEY (Id),
	FOREIGN KEY (EmployeeId) REFERENCES Employees (Id),
	FOREIGN KEY (AccountNumber) REFERENCES Customers (AccountNumber),
	CHECK (TotalDays = DATEDIFF(day, FirstDateOccupied, LastDateOccupied)),
	--drop the next 2 TaxRate ralated constraints before a TaxRate update (Problem 23)
	CONSTRAINT CK_Payments_TaxAmount CHECK (TaxAmount = AmountCharged * TaxRate), 
	CONSTRAINT CK_Payments_PaymentTotal CHECK (PaymentTotal = AmountCharged + TaxAmount)
)

CREATE TABLE Occupancies (
	Id int IDENTITY, 
	EmployeeId int NOT NULL, 
	DateOccupied date NOT NULL, 
	AccountNumber int NOT NULL, 
	RoomNumber int NOT NULL, 
	RateApplied money NOT NULL, 
	PhoneCharge money NOT NULL DEFAULT 0, 
	Notes nvarchar(max),
	PRIMARY KEY (Id),
	FOREIGN KEY (EmployeeId) REFERENCES Employees (Id),
	FOREIGN KEY (AccountNumber) REFERENCES Customers (AccountNumber),
	FOREIGN KEY (RoomNumber) REFERENCES Rooms (RoomNumber),
	CHECK (PhoneCharge >= 0)
)

INSERT INTO Employees (FirstName, LastName, Title, Notes)
VALUES
	('Tom', 'Barnes', 'Hotel Manager', NULL),
	('David', 'Jones', 'CEO', NULL),
	('Eva', 'Michado', 'Chambermaid', 'Late for work')
	
INSERT INTO Customers (FirstName, LastName, PhoneNumber, EmergencyName, EmergencyNumber)
VALUES
	('Angela','Merkel', 49123456789, 'Barroso', 32987654321),
	('Barack','Obama', 1123456789, NULL, NULL),
	('Margaret','Thacher', 41987654321, NULL, NULL)

INSERT INTO RoomStatus (RoomStatus)
VALUES
	('Reserved'), ('Occupied'), ('Available')

INSERT INTO RoomTypes (RoomType)
VALUES
	('Single'), ('Double'), ('Suite')

INSERT INTO BedTypes (BedType)
VALUES
	('Single'), ('Twin'), ('Double')

INSERT INTO Rooms (RoomType, BedType, Rate, RoomStatus)
VALUES
	('Single', 'Single', 70, 'Reserved'),
	('Double', 'Twin', 100, 'Occupied'),
	('Suite', 'Double', 110, 'Available')

INSERT INTO Payments (EmployeeId, PaymentDate, AccountNumber, FirstDateOccupied, LastDateOccupied, TotalDays, AmountCharged, TaxRate, TaxAmount, PaymentTotal)
VALUES
	(1, '2017-01-22', 1, '2017-01-21', '2017-01-22', 1, 100, 0.20, 20, 120),
	(1, '2017-01-22', 2, '2017-01-20', '2017-01-22', 2, 200, 0.20, 40, 240),
	(1, '2017-01-22', 3, '2017-01-19', '2017-01-22', 3, 300, 0.20, 60, 360)

INSERT INTO Occupancies (EmployeeId, DateOccupied, AccountNumber, RoomNumber, RateApplied, PhoneCharge)
VALUES
	(1, '2014-01-22', 1, 1, 70, 0),
	(2, '2014-01-22', 2, 2, 100, 0),
	(3, '2014-01-22', 3, 3, 110, 10)