SELECT CustomerID, CONCAT(FirstName, ' ', LastName) AS [FullName], Gender
FROM Customers
ORDER BY FullName, CustomerID