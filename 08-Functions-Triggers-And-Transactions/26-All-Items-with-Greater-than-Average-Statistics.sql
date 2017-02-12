WITH CTE_AboveAverageStats (Id) AS (  
  SELECT Id FROM [Statistics]
  WHERE Mind > (SELECT AVG(Mind  * 1.0) FROM [Statistics]) AND
        Luck > (SELECT AVG(Luck  * 1.0) FROM [Statistics]) AND
       Speed > (SELECT AVG(Speed * 1.0) FROM [Statistics])
)
SELECT 
  i.Name, i.Price, i.MinLevel, 
  s.Strength, s.Defence, s.Speed, s.Luck, s.Mind
FROM CTE_AboveAverageStats AS av
  JOIN [Statistics] AS s ON av.Id = s.Id
  JOIN Items AS i ON i.StatisticId = s.Id
ORDER BY i.Name