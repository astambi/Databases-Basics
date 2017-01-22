CREATE DATABASE SoftUni
GO
USE SoftUni

CREATE TABLE Towns (
	Id int IDENTITY, -- by default IDENTITY (1, 1)
	Name nvarchar(200) NOT NULL,
	CONSTRAINT PK_Towns PRIMARY KEY (Id)
)

CREATE TABLE Addresses (
	Id int IDENTITY, 
	AddressText nvarchar(max) NOT NULL,
	TownId int NOT NULL,
	CONSTRAINT PK_Addresses PRIMARY KEY (Id),
	CONSTRAINT FK_Addresses_Towns FOREIGN KEY (TownId) REFERENCES Towns (Id)
)

CREATE TABLE Departments (
	Id int IDENTITY, 
	Name nvarchar(200) NOT NULL,
	CONSTRAINT PK_Departments PRIMARY KEY (Id)
)

CREATE TABLE Employees (
	Id int IDENTITY,
	FirstName nvarchar(200) NOT NULL,
	MiddleName nvarchar(200),
	LastName nvarchar(200) NOT NULL,
	JobTitle nvarchar(200) NOT NULL, 
	DepartmentId int NOT NULL, 
	HireDate date NOT NULL, 
	Salary money NOT NULL, 
	AddressId int,
	CONSTRAINT PK_Employees PRIMARY KEY (Id),
	CONSTRAINT FK_Employees_Departments FOREIGN KEY (DepartmentId) REFERENCES Departments (Id),
	CONSTRAINT FK_Employees_Addresses FOREIGN KEY (AddressId) REFERENCES Addresses (Id),
	CONSTRAINT CK_Employees_Salary CHECK (Salary >= 0)
)