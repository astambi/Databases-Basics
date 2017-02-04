SELECT TOP 1
  AVG(Salary) AS MinAverageSalary
FROM Employees
GROUP BY DepartmentID
ORDER BY MinAverageSalary

-- another solution
SELECT 
  MIN(av.AverageSalary) AS MinAverageSalary
FROM 
 (SELECT AVG(Salary) AS AverageSalary
  FROM Employees
  GROUP BY DepartmentID) AS av