SELECT MAX(Salary) AS [HighestSalary]
FROM Employees

SELECT DISTINCT TOP 3 Salary AS [Top 3 highest salaries]
FROM Employees
ORDER BY Salary DESC

SELECT TOP 1 Salary AS [ThirdHighestSalary]
FROM 
  (SELECT DISTINCT TOP 3 Salary FROM Employees
   ORDER BY Salary DESC) AS HighestSalaries
ORDER BY Salary

SELECT Salary AS [ThirdHighestSalary]
FROM Employees Emp1
WHERE (2) = 
  (SELECT COUNT(DISTINCT(Emp2.Salary))
   FROM Employees Emp2
   WHERE Emp2.Salary > Emp1.Salary)

SELECT 
  DepartmentID,
  (SELECT DISTINCT Salary FROM Employees
   WHERE DepartmentID = e.DepartmentID
   ORDER BY Salary DESC 
   OFFSET 2 ROWS FETCH NEXT 1 ROWS ONLY) AS ThirdHighestSalary
FROM Employees e
WHERE 
  (SELECT DISTINCT Salary FROM Employees
   WHERE DepartmentID = e.DepartmentID
   ORDER BY Salary DESC 
   OFFSET 2 ROWS FETCH NEXT 1 ROWS ONLY) IS NOT NULL
GROUP BY DepartmentID

SELECT 
  sal.DepartmentId, 
  sal.Salary AS ThirdHighestSalary
FROM
  (SELECT e.DepartmentId, e.Salary, 
   DENSE_RANK() OVER 
     (PARTITION BY e.DepartmentID
      ORDER BY e.Salary DESC) AS SalaryRank
   FROM Employees AS e) AS sal
WHERE sal.SalaryRank = 3
GROUP BY sal.DepartmentID, sal.Salary