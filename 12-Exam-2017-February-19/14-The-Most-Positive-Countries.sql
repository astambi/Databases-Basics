SELECT TOP(1) WITH TIES
  co.Name AS CountryName, 
  AVG(f.Rate) AS FeedbackRate
FROM Feedbacks AS f
JOIN Customers AS c ON c.Id = F.CustomerId
JOIN Countries AS co ON co.Id = c.CountryId
GROUP BY co.Name
ORDER BY FeedbackRate DESC