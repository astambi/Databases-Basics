CREATE FUNCTION ufn_GetSalaryLevel(@salary MONEY) 
RETURNS varchar(10)
AS
BEGIN
  DECLARE @salaryLevel varchar(10)
  IF(@salary < 30000)       SET @salaryLevel = 'Low'
  ELSE IF(@salary <= 50000) SET @salaryLevel = 'Average'
  ELSE                      SET @salaryLevel = 'High'
  RETURN @salaryLevel
END;

-- for testing purposes only - do not submit in Judge
SELECT Salary, 
  dbo.ufn_GetSalaryLevel(Salary) AS [Salary Level]
FROM Employees 
ORDER BY Salary DESC