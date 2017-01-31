SELECT 
  DepartmentID, 
  MIN(Salary) AS MinSalary
FROM Employees
GROUP BY DepartmentID
ORDER BY DepartmentID

SELECT 
  DepartmentID, 
  COUNT(Salary) AS SalaryCount
FROM Employees
GROUP BY DepartmentID

SELECT 
  DepartmentID, 
  SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY DepartmentID

SELECT 
  DepartmentID, 
  MAX(Salary) AS MaxSalary
FROM Employees
GROUP BY DepartmentID

SELECT 
  DepartmentID, 
  MIN(Salary) AS MinSalary
FROM Employees
GROUP BY DepartmentID

SELECT 
  DepartmentID, 
  AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DepartmentID

SELECT 
  DepartmentID, 
  SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY DepartmentID
HAVING SUM(Salary) < 250000