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

-- solution with DENSE_RANK
SELECT DepartmentID, Salary AS ThirdHighestSalary
FROM 
  (SELECT DepartmentID, Salary,
     DENSE_RANK() OVER (PARTITION BY DepartmentId ORDER BY Salary DESC) AS Rank
   FROM Employees
   GROUP BY DepartmentID, Salary) AS RankedSalaries
WHERE RankedSalaries.Rank = 3