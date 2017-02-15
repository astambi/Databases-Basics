SELECT DISTINCT
  a.AirportID, 
  a.AirportName, 
  COUNT(c.CustomerID) AS [Passengers]
FROM Airports AS a
JOIN Flights AS f ON f.OriginAirportID = a.AirportID
JOIN Tickets AS ti ON f.FlightID = ti.FlightID
JOIN Customers AS c ON ti.CustomerID = c.CustomerID
WHERE f.Status = 'Departing'
GROUP BY a.AirportID, a.AirportName
HAVING COUNT(c.CustomerID) > 0
ORDER BY a.AirportID