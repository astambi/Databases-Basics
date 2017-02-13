SELECT c.CountryName, cont.ContinentName, 
  COUNT(r.Id) AS RiverCount, 
  ISNULL(SUM(r.Length), 0) AS TotalLength
FROM Countries AS c
  LEFT JOIN CountriesRivers AS cr ON c.CountryCode = cr.CountryCode
  LEFT JOIN Rivers AS r ON cr.RiverId = r.Id
  LEFT JOIN Continents AS cont on c.ContinentCode = cont.ContinentCode
GROUP BY c.CountryName, cont.ContinentName
ORDER BY RiverCount DESC, TotalLength DESC, c.CountryName