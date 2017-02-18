SELECT CustomerID, Height
FROM Customers
WHERE Height BETWEEN 1.74 AND 2.04
  AND CustomerID NOT IN (SELECT CustomerID FROM Accounts)