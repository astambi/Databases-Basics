SELECT TOP (15) 
  i.Name, i.Description, c.Name AS CountryName
FROM Ingredients AS i
JOIN Countries AS c ON c.Id = i.OriginCountryId
WHERE c.Name IN ('Bulgaria', 'Greece')
ORDER BY i.Name, c.Name