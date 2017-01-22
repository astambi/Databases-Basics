CREATE DATABASE School
GO

USE School
GO

CREATE TABLE Students(
	Id int NOT NULL, 
	Name nvarchar(50) NOT NULL, 
	Age int, 
	PhoneNumber int,
	CONSTRAINT PK_Students PRIMARY KEY(Id))

CREATE TABLE Classes(
	Id int NOT NULL, 
	Name nvarchar(50) NOT NULL, 
	MaxStudents int,
	CONSTRAINT PK_Classes PRIMARY KEY(Id))

CREATE TABLE Teachers(
	Id int NOT NULL, 
	Name nvarchar(50) NOT NULL, 
	Class nvarchar(50),
	CONSTRAINT PK_Teachers PRIMARY KEY(Id))

INSERT Classes (Id, Name, MaxStudents) VALUES (1, N'JS Core', 250)
INSERT Classes (Id, Name, MaxStudents) VALUES (2, N'C# DB Fundamentals', 250)
INSERT Classes (Id, Name, MaxStudents) VALUES (3, N'Web Basics', 250)

INSERT Teachers (Id, Name, Class) VALUES (1, N'Nakov', N'JS Core')
INSERT Teachers (Id, Name, Class) VALUES (2, N'Kenov', N'C# DB Fundamentals')
INSERT Teachers (Id, Name, Class) VALUES (3, N'Unknown', N'Web Basics')

INSERT Students (Id, Name, Age, PhoneNumber) VALUES (1, N'SoftUni Student A', 30, 123456789)
INSERT Students (Id, Name, Age, PhoneNumber) VALUES (2, N'SoftUni Student B', 25, 987654321)
INSERT Students (Id, Name, Age, PhoneNumber) VALUES (3, N'SoftUni Student C', NULL, 111111111)

DELETE FROM Classes
WHERE Id=3

UPDATE Teachers
SET Name = 'Cant be Nakov'
WHERE Id=3

UPDATE Students
SET Age = 35, 
	PhoneNumber = 999999999
WHERE Id=3