UPDATE Employees 
SET ManagerID = (
  SELECT
    CASE
      WHEN (EmployeeID BETWEEN 2 AND 10) OR (EmployeeID IN (11, 21)) THEN 1
      WHEN EmployeeID BETWEEN 12 AND 20 THEN 11
      WHEN EmployeeID BETWEEN 22 AND 30 THEN 21
      END
)
FROM Employees
WHERE EmployeeID <= 30