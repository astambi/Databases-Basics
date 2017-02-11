CREATE FUNCTION ufn_GetSalaryLevel(@salary money)
RETURNS varchar(10)
AS  
BEGIN
  DECLARE @salaryLevel varchar(10) = 'High';
  IF(@salary < 30000)       SET @salaryLevel = 'Low';
  ELSE IF(@salary <= 50000) SET @salaryLevel = 'Average';
  RETURN @salaryLevel;
END

--testing only, do not submit in Judge
SELECT Salary, 
  dbo.udf_GetSalaryLevel(Salary) AS [Salary Level]
FROM Employees
ORDER BY Salary DESC