SELECT TOP 3
  c.CustomerID, 
  CONCAT(c.FirstName, ' ', c.LastName) AS [FullName], 
  ti.Price AS [TicketPrice], 
  a.AirportName AS [Destination]
FROM Tickets AS ti
JOIN Customers AS c ON ti.CustomerID = c.CustomerID
JOIN Flights AS f ON ti.FlightID = f.FlightID
JOIN Airports AS a ON f.DestinationAirportID = a.AirportID
WHERE f.Status = 'Delayed'
ORDER BY TicketPrice DESC