SELECT 
  ti.TicketID, 
  a.AirportName AS Destination, 
  CONCAT(c.FirstName, ' ', c.LastName) AS [CustomerName]
FROM Tickets AS ti
JOIN Flights AS f on ti.FlightID = f.FlightID
JOIN Airports AS a ON f.DestinationAirportID = a.AirportID
JOIN Towns AS t ON a.TownID = t.TownID
JOIN Customers AS c ON c.CustomerID = ti.CustomerID
WHERE ti.Price < 5000 AND ti.Class = 'First'
ORDER BY ti.TicketID