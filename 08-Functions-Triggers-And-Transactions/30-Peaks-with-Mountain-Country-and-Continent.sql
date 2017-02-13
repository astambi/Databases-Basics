SELECT p.PeakName, m.MountainRange AS Mountain, c.CountryName, cont.ContinentName
FROM Peaks AS p
  JOIN Mountains AS m ON p.MountainId = m.Id
  JOIN MountainsCountries AS mc ON m.Id = mc.MountainId
  JOIN Countries AS c ON mc.CountryCode = c.CountryCode
  JOIN Continents AS cont ON c.ContinentCode = cont.ContinentCode
ORDER BY p.PeakName, c.CountryName