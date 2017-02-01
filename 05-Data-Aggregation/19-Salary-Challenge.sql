SELECT TOP 10
  FirstName, LastName, e.DepartmentID 
FROM Employees AS e
INNER JOIN (
  SELECT DepartmentID, AVG(Salary) AS AverageSalary
  FROM Employees 
  GROUP BY DepartmentID) AS av
ON e.DepartmentID = av.DepartmentID
WHERE Salary > AverageSalary
ORDER BY e.DepartmentID

-- how come a different output ?!
SELECT
  DepartmentID, AVG(Salary) AS AverageSalary
INTO AverageSalaries
FROM Employees
GROUP BY DepartmentID

SELECT TOP 10
  FirstName, LastName, e.DepartmentID 
FROM Employees AS e
INNER JOIN AverageSalaries AS av
ON e.DepartmentID = av.DepartmentID
WHERE Salary > AverageSalary
ORDER BY e.DepartmentID