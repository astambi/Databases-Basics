SELECT TOP (1) WITH TIES
  c.CustomerID, c.FirstName, a.StartDate
FROM Accounts AS a
JOIN Customers AS c ON c.CustomerID = a.CustomerID
ORDER BY a.StartDate