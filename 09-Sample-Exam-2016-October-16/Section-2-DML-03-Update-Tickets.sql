UPDATE Tickets
SET Price *= 1.5
WHERE TicketID IN (
  SELECT t.TicketID
  FROM Airlines AS a
  JOIN Flights AS f ON f.AirlineID = a.AirlineID
  JOIN Tickets AS t ON t.FlightID = f.FlightID
  WHERE a.Rating = (SELECT MAX(Rating) FROM Airlines)
)