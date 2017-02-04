CREATE DATABASE Examples
GO

USE Examples
GO

-- One-to-Many / Many-to-One
CREATE TABLE Mountains(
  MountainID INT PRIMARY KEY,
  MountainName VARCHAR(50)
)
CREATE TABLE Peaks(
  PeakId INT PRIMARY KEY,
  MountainID INT,
  CONSTRAINT FK_Peaks_Mountains FOREIGN KEY (MountainID) REFERENCES Mountains(MountainID)
)

-- Many-to-Many
CREATE TABLE Employees(
  EmployeeID INT PRIMARY KEY,
  EmployeeName VARCHAR(50)
)
CREATE TABLE Projects(
  ProjectID INT PRIMARY KEY,
  ProjectName VARCHAR(50)
)
CREATE TABLE EmployeesProjects(
  EmployeeID INT,
  ProjectID INT,
  CONSTRAINT PK_EmployeesProjects PRIMARY KEY (EmployeeID, ProjectID),
  CONSTRAINT FK_EmployeesProjects_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
  CONSTRAINT FK_EmployeesProjects_Projects  FOREIGN KEY (ProjectID)  REFERENCES Projects(ProjectID)
)

-- One-to-One
CREATE TABLE Drivers(
  DriverID INT PRIMARY KEY,
  DriverName VARCHAR(50)
)
CREATE TABLE Cars(
  CarID INT PRIMARY KEY,
  DriverID INT UNIQUE, -- NB!
  CONSTRAINT FK_Cars_Drivers FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID)
)

-- CASCADE Delete / Update
CREATE TABLE Drivers(
  DriverID INT PRIMARY KEY,
  DriverName VARCHAR(50)
)

CREATE TABLE Cars(
  CarID INT PRIMARY KEY,
  DriverID INT,
  CONSTRAINT FK_Car_Driver FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID) 
    ON DELETE CASCADE
--  ON UPDATE CASCADE
)