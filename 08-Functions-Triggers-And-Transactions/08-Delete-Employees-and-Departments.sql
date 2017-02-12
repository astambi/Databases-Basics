-- delete projects for employees in targeted departments
DELETE FROM EmployeesProjects
WHERE EmployeeID IN (
  SELECT e.EmployeeID FROM Employees AS e 
  JOIN Departments AS d ON e.DepartmentID = d.DepartmentID
  WHERE d.Name IN ('Production', 'Production Control')
)
-- make ManagerID in Departments nullable
ALTER TABLE Departments
ALTER COLUMN ManagerID int NULL
-- set ManagerID = NULL for targeted departments
UPDATE Departments
SET ManagerID = NULL
WHERE Name IN ('Production', 'Production Control')
-- set ManagerID = NULL for employees in targeted departments
UPDATE Employees
SET ManagerID = NULL
WHERE DepartmentID IN (
  SELECT DepartmentID FROM Departments
  WHERE Name IN ('Production', 'Production Control')
)
-- drop constraint ManagerID_EmployeeID
ALTER TABLE Employees
DROP CONSTRAINT FK_Employees_Employees
-- delete employees from targeted departments
DELETE FROM Employees
WHERE DepartmentID IN (
  SELECT DepartmentID FROM Departments
  WHERE Name IN ('Production', 'Production Control')
)
-- delete targeted departements
DELETE FROM Departments
WHERE Name IN ('Production', 'Production Control')


-- testing for targeted departements & employees in DB - do not submit in Judge
SELECT * FROM EmployeesProjects
WHERE EmployeeID IN (
  SELECT e.EmployeeID FROM Employees e 
  JOIN Departments d ON E.DepartmentID = D.DepartmentID
  WHERE D.Name IN ('Production', 'Production Control')
)
SELECT d.DepartmentID, d.Name AS Department, d.ManagerID as DeptManager, 
  e.EmployeeID, e.FirstName, e.LastName, e.ManagerID as EmplManager, E.JobTitle
  FROM Departments AS d
  JOIN Employees AS e ON d.DepartmentID = e.DepartmentID
  WHERE d.Name IN ('Production', 'Production Control')  
SELECT DepartmentID, Name AS Department
  FROM Departments
  WHERE Name IN ('Production', 'Production Control')

-- restoring modified DB constraints
ALTER TABLE Departments
ALTER COLUMN ManagerID int NOT NULL
-- why can't self-referencing be restored as well ???
ALTER TABLE Employees
ADD CONSTRAINT FK_Employees_Employees FOREIGN KEY(ManagerID)
REFERENCES Employees(EmployeeID)