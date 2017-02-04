SELECT
  CountryCode, COUNT(MountainId) AS MountainRanges
FROM MountainsCountries
WHERE CountryCode IN ('US', 'BG', 'RU')
GROUP BY CountryCode

-- another solution
SELECT
  mc.CountryCode, COUNT(mc.MountainId) AS MountainRanges
FROM Countries AS c
JOIN MountainsCountries AS mc ON c.CountryCode = mc.CountryCode
WHERE c.CountryName IN ('United States', 'Bulgaria', 'Russia')
GROUP BY mc.CountryCode