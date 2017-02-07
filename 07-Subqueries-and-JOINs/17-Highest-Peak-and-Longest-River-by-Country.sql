SELECT TOP 5
  TopPeaks.CountryName,
  TopPeaks.HighestPeakElevation,
  TopRivers.LongestRiverLength
FROM 
  (SELECT CountryName, MAX(p.Elevation) AS HighestPeakElevation
   FROM Countries AS c
   LEFT JOIN MountainsCountries AS mc ON c.CountryCode = mc.CountryCode
   LEFT JOIN Peaks AS p ON p.MountainId = mc.MountainId
   GROUP BY CountryName) AS TopPeaks
LEFT JOIN 
  (SELECT CountryName, MAX(r.Length) AS LongestRiverLength
   FROM Countries AS c
   LEFT JOIN CountriesRivers AS cr ON c.CountryCode = cr.CountryCode
   LEFT JOIN Rivers AS r ON r.Id = cr.RiverId
   GROUP BY CountryName) AS TopRivers
ON TopPeaks.CountryName = TopRivers.CountryName
ORDER BY 
  HighestPeakElevation DESC, 
  LongestRiverLength DESC,
  CountryName
  
-- solution with JOINs only, no subqueries
SELECT TOP 5
  c.CountryName,
  MAX(p.Elevation) AS HighestPeakElevation,
  MAX(r.Length) AS LongestRiverLength
FROM Countries AS c
LEFT JOIN MountainsCountries AS mc ON c.CountryCode = mc.CountryCode
LEFT JOIN Peaks AS p ON p.MountainId = mc.MountainId
LEFT JOIN CountriesRivers AS cr ON c.CountryCode = cr.CountryCode
LEFT JOIN Rivers AS r ON r.Id = cr.RiverId
GROUP BY c.CountryName
ORDER BY 
  HighestPeakElevation DESC, 
  LongestRiverLength DESC,
  c.CountryName
  
-- solution with CTE
WITH PeaksRivers_CTE (CountryName, PeakElevation, RiverLength) AS (
  SELECT c.CountryName, p.Elevation, r.Length
  FROM Countries AS c
  LEFT JOIN MountainsCountries AS mc ON c.CountryCode = mc.CountryCode
  LEFT JOIN Peaks AS p ON p.MountainId = mc.MountainId
  LEFT JOIN CountriesRivers AS cr ON c.CountryCode = cr.CountryCode
  LEFT JOIN Rivers AS r ON r.Id = cr.RiverId
)
SELECT TOP 5
  CountryName,
  MAX(PeakElevation) AS HighestPeakElevation,
  MAX(RiverLength) AS LongestRiverLength
FROM PeaksRivers_CTE
GROUP BY CountryName
ORDER BY 
  HighestPeakElevation DESC, 
  LongestRiverLength DESC,
  CountryName