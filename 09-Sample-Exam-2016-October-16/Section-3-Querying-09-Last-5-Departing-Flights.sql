WITH CTE_Last5Flights (FlightID) AS (
  SELECT TOP 5 FlightID FROM Flights
  WHERE Status = 'Departing'
  ORDER BY DepartureTime DESC
)
SELECT TOP 5
  f.FlightID AS FlightID,
  f.DepartureTime, 
  f.ArrivalTime, 
  ao.AirportName AS [Origin],
  ad.AirportName AS [Destination]
FROM CTE_Last5Flights AS last5
JOIN Flights AS f ON last5.FlightID = f.FlightID
JOIN Airports AS ao ON f.OriginAirportID = ao.AirportID 
JOIN Airports AS ad ON f.DestinationAirportID = ad.AirportID
ORDER BY f.DepartureTime, f.FlightID