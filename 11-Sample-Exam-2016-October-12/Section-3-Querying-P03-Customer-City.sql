SELECT c.CustomerID, c.FirstName, c.LastName, c.Gender, ci.CityName
FROM Customers AS c
JOIN Cities AS ci ON c.CityID = ci.CityID
WHERE (c.LastName LIKE 'Bu%' OR c.FirstName LIKE '%a')
  AND LEN(ci.CityName) >= 8
ORDER BY c.CustomerID