-- USE SoftUni
SELECT FirstName, LastName 
FROM Employees

SELECT * FROM Projects
WHERE StartDate = '2003/6/1'

INSERT INTO Projects (Name, StartDate)
VALUES ('Introduction to SQL Course', '2017/1/16')

UPDATE Projects
SET EndDate = '2017/2/19'
WHERE StartDate = '2017/1/16'

DELETE FROM Projects
WHERE StartDate = '2017/1/16'

-- T-SQL example
CREATE PROCEDURE EmpDump AS
  DECLARE @EmpId INT, @EmpFName NVARCHAR(100), @EmpLName NVARCHAR(100)
  DECLARE emps CURSOR FOR
    SELECT EmployeeID, FirstName, LastName FROM Employees
  OPEN emps
  FETCH NEXT FROM emps INTO @EmpId, @EmpFName, @EmpLName
  WHILE (@@FETCH_STATUS = 0) BEGIN
    PRINT CAST(@EmpId AS VARCHAR(10)) + ' ' + @EmpFName + ' ' + @EmpLName
    FETCH NEXT FROM emps INTO @EmpId, @EmpFName, @EmpLName
  END
  CLOSE emps
  DEALLOCATE emps
GO

-- SELECT
SELECT * FROM Departments

SELECT DepartmentID, Name 
FROM Departments

SELECT 
	EmployeeID AS ID, 
	FirstName, 
	LastName
FROM Employees

SELECT
	e.LastName AS [Employee's Last Name], -- brackets [] for special symbols
	e.FirstName AS 'First Name' -- otherwise single quotes ''
FROM Employees AS e

SELECT 
	FirstName + ' ' + LastName AS [Full Name], -- concatenate
	EmployeeID AS [Employee's Id]
FROM Employees

SELECT 
	FirstName + ' ' + LastName AS [Full Name], 
	JobTitle, 
	Salary
FROM Employees

SELECT DISTINCT DepartmentID
FROM Employees

SELECT LastName, DepartmentID
FROM Employees
WHERE DepartmentID = 1

SELECT LastName, Salary
FROM Employees
WHERE Salary <= 20000

SELECT LastName
FROM Employees
WHERE NOT (ManagerID = 3 OR ManagerID = 4)

SELECT LastName, Salary
FROM Employees
WHERE Salary BETWEEN 20400 AND 21600 -- range inclusive [20400, 21600]

SELECT FirstName, LastName, ManagerID
FROM Employees
WHERE ManagerID IN (109, 3, 16)

SELECT LastName, ManagerID
FROM Employees
WHERE ManagerID IS NULL -- NB! ManagerID = NULL => not working

SELECT LastName, ManagerID
FROM Employees
WHERE ManagerID IS NOT NULL

SELECT LastName, HireDate
FROM Employees
ORDER BY HireDate -- by default ASC

SELECT LastName, HireDate
FROM Employees
ORDER BY HireDate DESC

-- CREATE VIEW
CREATE VIEW V_HRResultSet AS
SELECT 
	FirstName + ' ' + LastName AS [Full Name],
	Salary
FROM Employees 

SELECT * FROM V_HRResultSet
ORDER BY Salary DESC

-- USE Geography
CREATE VIEW V_HighestPeak AS
SELECT TOP (1) *
FROM Peaks
ORDER BY Elevation DESC

SELECT * FROM V_HighestPeak

-- INSERT INTO
-- USE SoftUni
INSERT INTO Towns
VALUES ('Paris')

INSERT INTO Projects (Name, StartDate)
VALUES ('Reflective Jacket', GETDATE())

INSERT INTO EmployeesProjects
VALUES (229, 1), (229, 2), (229, 3)

SELECT FirstName, LastName, JobTitle
INTO SoftUniStaff -- new table
FROM Employees

INSERT INTO Projects (Name, StartDate)
SELECT Name + ' Restructuring', GETDATE()
FROM Departments

-- CREATE SEQUENCE
CREATE SEQUENCE SEQ_Employees_EmployeeID AS INT
START WITH 1
INCREMENT BY 1

SELECT NEXT VALUE FOR SEQ_Employees_EmployeeID -- returns the next value

-- DELETE, TRUNCATE & UPDATE - NB don't foget the WHERE clause!
DELETE FROM SoftUniStaff
WHERE LastName = 'Nakov'

TRUNCATE TABLE SoftUniStaff -- faster than DELETE FROM 

UPDATE Employees
SET LastName = 'Updated Name Brown'
WHERE EmployeeID = 1

UPDATE Employees
SET Salary *= 1.2,
	JobTitle = 'Senior ' + JobTitle
WHERE DepartmentID = 3

UPDATE Projects
SET EndDate = GETDATE()
WHERE EndDate IS NULL