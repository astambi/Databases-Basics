SELECT 
  Result.ProductName, Result.ProductAverageRate, 
  Result.DistributorName, Result.DistributorCountry
FROM (
  SELECT 
    p.Name AS ProductName, AVG(f.Rate) AS ProductAverageRate,
    d.Name AS DistributorName, c.Name AS DistributorCountry
  FROM (
    SELECT p.Id
    FROM Products AS p
    JOIN ProductsIngredients AS pi ON pi.ProductId = p.Id
    JOIN Ingredients AS i ON pi.IngredientId = i.Id
    JOIN Distributors AS d ON i.DistributorId = d.Id
    GROUP BY p.Id
    HAVING COUNT(DISTINCT d.Id) = 1
  ) AS SingleDistProducts
  JOIN Products AS p ON p.Id = SingleDistProducts.Id
  JOIN ProductsIngredients AS pi ON pi.ProductId = p.Id
  JOIN Ingredients AS i ON pi.IngredientId = i.Id
  JOIN Distributors AS d ON d.Id = i.DistributorId
  JOIN Countries AS c ON d.CountryId = c.Id
  JOIN Feedbacks AS f ON p.Id = f.ProductId
  GROUP BY p.Name, d.Name, c.Name
) AS Result
JOIN Products p1 on p1.Name = Result.ProductName
ORDER BY p1.Id