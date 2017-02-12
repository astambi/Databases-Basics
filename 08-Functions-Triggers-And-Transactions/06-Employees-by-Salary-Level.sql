-- Using Function ufn_GetSalaryLevel from Problem 05
CREATE PROC usp_EmployeesBySalaryLevel (@salaryLevel varchar(10))
AS
  SELECT FirstName, LastName
  FROM Employees
  WHERE dbo.ufn_GetSalaryLevel(Salary) = @salaryLevel

-- testing
EXEC usp_EmployeesBySalaryLevel 'High';