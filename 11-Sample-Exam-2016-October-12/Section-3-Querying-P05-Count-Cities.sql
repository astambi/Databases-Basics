SELECT 
  c.CityName, b.Name,
  COUNT(e.EmployeeID) AS EmployeesCount
FROM Cities AS c
JOIN Branches AS b ON b.CityID = c.CityID
JOIN Employees AS e ON b.BranchID = e.BranchID
WHERE c.CityID NOT IN (4, 5)
GROUP BY c.CityName, b.Name
HAVING COUNT(e.EmployeeID) >= 3