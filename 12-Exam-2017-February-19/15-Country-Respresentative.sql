SELECT CountryName, DistributorName
FROM (
  SELECT 
    co.Name AS CountryName, d.Name AS DistributorName, 
    COUNT(i.Id) AS IngredientsCount,
    DENSE_RANK() OVER (PARTITION BY co.Name ORDER BY COUNT(i.Id) DESC) AS DistributorRank 
	-- ranking for most active distributor by country (delivering max IngredientsCount) 
  FROM Countries AS co
  JOIN Distributors AS d ON d.CountryId = co.Id
  JOIN Ingredients AS i ON i.DistributorId = d.Id
  GROUP BY d.Name, co.Name
) AS CountryDistributorStats
WHERE DistributorRank = 1
ORDER BY CountryName, DistributorName