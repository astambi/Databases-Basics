CREATE PROC usp_GetEmployeesSalaryAbove35000
AS
  SELECT FirstName, LastName
  FROM Employees
  WHERE Salary > 35000
  
-- testing
EXEC usp_GetEmployeesSalaryAbove35000