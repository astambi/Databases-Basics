SELECT p.Name, p.Description, BestRated.AverageRate, BestRated.FeedbacksAmount
FROM (
  SELECT TOP (10)
    ProductId, 
    AVG(Rate) AS AverageRate, 
    COUNT(Id) AS FeedbacksAmount
  FROM Feedbacks
  GROUP BY ProductId
  ORDER BY AverageRate DESC, FeedbacksAmount DESC
) AS BestRated
JOIN Products AS p ON p.Id = BestRated.ProductId