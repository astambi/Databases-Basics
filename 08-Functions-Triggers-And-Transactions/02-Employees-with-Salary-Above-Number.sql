CREATE PROC usp_GetEmployeesSalaryAboveNumber (@minSalary money)
AS
  SELECT FirstName, LastName
  FROM Employees
  WHERE Salary >= @minSalary

-- testing
EXEC usp_GetEmployeesSalaryAboveNumber 48100;