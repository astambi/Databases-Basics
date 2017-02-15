SELECT DISTINCT
  c.CustomerID, 
  CONCAT(c.FirstName, ' ', c.LastName) AS [FullName], 
  ct.TownName AS [HomeTown]
FROM Tickets AS ti
JOIN Customers AS c ON ti.CustomerID = c.CustomerID
JOIN Towns AS ct ON c.HomeTownID = ct.TownID
JOIN Flights AS f ON ti.FlightID = f.FlightID
JOIN Airports AS a ON f.OriginAirportID = a.AirportID
WHERE c.HomeTownID = a.TownID
ORDER BY c.CustomerID