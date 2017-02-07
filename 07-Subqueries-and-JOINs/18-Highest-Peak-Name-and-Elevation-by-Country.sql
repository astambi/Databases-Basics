-- solution with Common Table Expression & subqueries
WITH PeaksMountains_CTE (CountryName, PeakName, Elevation, Mountain) AS (
  SELECT c.CountryName, p.PeakName, p.Elevation, m.MountainRange
  FROM Countries AS c
  LEFT JOIN MountainsCountries as mc ON c.CountryCode = mc.CountryCode
  LEFT JOIN Mountains AS m ON mc.MountainId = m.Id
  LEFT JOIN Peaks AS p ON p.MountainId = m.Id
)
SELECT TOP 5
  TopElevations.CountryName AS Country,
  ISNULL((SELECT PeakName FROM PeaksMountains_CTE
          WHERE TopElevations.CountryName = CountryName AND TopElevations.HighestElevation = Elevation), 
         '(no highest peak)') AS HighestPeakName,
  ISNULL(TopElevations.HighestElevation, 0) AS HighestPeakElevation,
  ISNULL((SELECT Mountain FROM PeaksMountains_CTE
          WHERE TopElevations.CountryName = CountryName AND TopElevations.HighestElevation = Elevation), 
        '(no mountain)') AS Mountain
FROM 
  (SELECT CountryName, MAX(Elevation) AS HighestElevation
   FROM PeaksMountains_CTE 
   GROUP BY CountryName) AS TopElevations
ORDER BY Country, HighestPeakName

-- solution with subqueries
SELECT TOP 5
  TopElevations.CountryName AS Country,
  ISNULL((SELECT p.PeakName 
          FROM Peaks AS p
          JOIN MountainsCountries as mc ON mc.MountainId = p.MountainId
          JOIN Countries AS c ON c.CountryCode = mc.CountryCode
          WHERE TopElevations.CountryName = c.CountryName AND TopElevations.HighestElevation = p.Elevation), 
        '(no highest peak)') AS HighestPeakName,
  ISNULL(TopElevations.HighestElevation, 0) AS HighestPeakElevation,
  ISNULL((SELECT m.MountainRange 
          FROM Mountains AS m
          JOIN MountainsCountries as mc ON mc.MountainId = m.Id
          JOIN Countries AS c ON c.CountryCode = mc.CountryCode
          JOIN Peaks AS p ON p.MountainId = m.Id
          WHERE TopElevations.CountryName = c.CountryName AND TopElevations.HighestElevation = p.Elevation), 
        '(no mountain)') AS Mountain
FROM 
  (SELECT c.CountryName, MAX(p.Elevation) AS HighestElevation
   FROM Countries AS c
   LEFT JOIN MountainsCountries mc ON mc.CountryCode = c.CountryCode
   LEFT JOIN Peaks AS p ON p.MountainId = mc.MountainId
   GROUP BY c.CountryName) AS TopElevations
ORDER BY Country, HighestPeakName

--solution with subqueries
SELECT TOP 5
  TopElevations.CountryName AS Country,
  ISNULL((SELECT p.PeakName 
          FROM Peaks AS p
          JOIN MountainsCountries as mc ON mc.MountainId = p.MountainId
          JOIN Countries AS c ON (c.CountryCode = mc.CountryCode 
           AND TopElevations.CountryName = c.CountryName 
           AND TopElevations.HighestElevation = p.Elevation)), 
        '(no highest peak)') AS HighestPeakName,
  ISNULL(TopElevations.HighestElevation, 0) AS HighestPeakElevation,
  ISNULL((SELECT m.MountainRange 
          FROM Mountains AS m
          JOIN MountainsCountries as mc ON mc.MountainId = m.Id
          JOIN Countries AS c ON c.CountryCode = mc.CountryCode
          JOIN Peaks AS p ON (p.MountainId = m.Id
           AND TopElevations.CountryName = c.CountryName 
           AND TopElevations.HighestElevation = p.Elevation)), 
        '(no mountain)') AS Mountain
FROM 
  (SELECT c.CountryName, MAX(p.Elevation) AS HighestElevation
   FROM Countries AS c
   LEFT JOIN MountainsCountries mc ON mc.CountryCode = c.CountryCode
   LEFT JOIN Peaks AS p ON p.MountainId = mc.MountainId
   GROUP BY c.CountryName) AS TopElevations
ORDER BY Country, HighestPeakName


