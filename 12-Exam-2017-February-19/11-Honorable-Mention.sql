SELECT 
  f.ProductId, 
  CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
  ISNULL(f.Description, '') AS FeedbackDescription
FROM Feedbacks AS f
JOIN (
  SELECT CustomerId
  FROM Feedbacks
  GROUP BY CustomerId
  HAVING COUNT(Id) >= 3
) AS topCust ON f.CustomerId = topCust.CustomerId
JOIN Customers AS c ON c.Id = topCust.CustomerId
ORDER BY f.ProductId, CustomerName, f.Id