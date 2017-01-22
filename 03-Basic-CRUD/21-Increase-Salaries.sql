UPDATE Employees
SET Salary *= 1.12
WHERE DepartmentID IN (
	SELECT DepartmentID FROM Departments
	WHERE Name IN ('Engineering', 'Tool Design', 'Marketing', 'Information Services'))

SELECT Salary FROM Employees

-- Restore DB to revert changes (do not submit in Judge)
UPDATE Employees
SET Salary /= 1.12
WHERE DepartmentID IN (
	SELECT DepartmentID FROM Departments
	WHERE Name IN ('Engineering', 'Tool Design', 'Marketing', 'Information Services'))