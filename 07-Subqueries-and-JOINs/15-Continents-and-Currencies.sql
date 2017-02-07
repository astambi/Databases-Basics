WITH CCYContUsage_CTE (ContinentCode, CurrencyCode, CurrencyUsage) AS (
  SELECT ContinentCode, CurrencyCode, COUNT(CountryCode) AS CurrencyUsage
  FROM Countries
  GROUP BY ContinentCode, CurrencyCode
  HAVING COUNT(CountryCode) > 1  
)
SELECT
  cont.ContinentCode, ccy.CurrencyCode, cont.TopCCYUsage
FROM -- Top Currency Usage per Continent
  (SELECT ContinentCode, MAX(CurrencyUsage) AS TopCCYUsage
   FROM CCYContUsage_CTE GROUP BY ContinentCode) AS cont 
JOIN CCYContUsage_CTE AS ccy ON cont.ContinentCode = ccy.ContinentCode
WHERE cont.TopCCYUsage = ccy.CurrencyUsage
ORDER BY cont.ContinentCode