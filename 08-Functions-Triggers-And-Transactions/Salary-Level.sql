CREATE FUNCTION udf_GetSalaryLevel(@salary money)
RETURNS varchar(10)
AS
BEGIN
  DECLARE @salaryLevel varchar(10);
  IF(@salary < 30000)       SET @salaryLevel = 'Low';
  ELSE IF(@salary <= 50000) SET @salaryLevel = 'Average';
  ELSE                      SET @salaryLevel = 'High';
  RETURN @salaryLevel;
END;
GO

SELECT Salary, dbo.udf_GetSalaryLevel(Salary) AS SalaryLevel
FROM Employees
ORDER BY Salary DESC