SELECT TOP 3
  e.EmployeeID, e.FirstName
FROM Employees AS e
LEFT JOIN EmployeesProjects AS p ON p.EmployeeID = e.EmployeeID
WHERE p.EmployeeID IS NULL
ORDER BY e.EmployeeID