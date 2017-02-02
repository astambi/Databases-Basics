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

-- another solution
SELECT TOP 10
  FirstName, LastName, DepartmentID
FROM Employees AS emp1
WHERE Salary >
  (SELECT AVG(Salary)
   FROM Employees AS emp2
   WHERE emp1.DepartmentID = emp2.DepartmentID
   GROUP BY DepartmentID)
ORDER BY DepartmentID

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