SELECT TOP (5)
  c.CustomerID, l.Amount
FROM Loans AS l
JOIN Customers AS c ON c.CustomerID = l.CustomerID
WHERE l.Amount > (
  SELECT AVG(l.Amount)
  FROM Customers AS c 
  /*LEFT*/ JOIN Loans AS l ON c.CustomerID = l.CustomerID
  WHERE c.Gender = 'M'
)
ORDER BY c.LastName