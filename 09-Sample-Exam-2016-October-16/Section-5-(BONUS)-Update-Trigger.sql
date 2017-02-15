--CREATE TABLE ArrivedFlights(
--  FlightID int NOT NULL, 
--  ArrivalTime date NOT NULL,
--  Origin varchar(50) NOT NULL,
--  Destination varchar(50) NOT NULL,
--  Passengers int NOT NULL,
--  CONSTRAINT PK_ArrivedFlights PRIMARY KEY (FlightID)
--)

CREATE TRIGGER tr_UpdateFlightStatusToArrived ON Flights FOR UPDATE
AS
BEGIN
  INSERT INTO ArrivedFlights (FlightID, ArrivalTime, Origin, Destination, Passengers) 
  (
    SELECT 
      i.FlightID, i.ArrivalTime, ao.AirportName, ad.AirportName, 
      ISNULL(COUNT(ti.CustomerID), 0)
    FROM inserted AS i
    JOIN Airports AS ao ON ao.AirportID = i.OriginAirportID
    JOIN Airports AS ad ON ad.AirportID = i.DestinationAirportID
    LEFT JOIN Tickets AS ti ON ti.FlightID = i.FlightID -- no tickets, no passengers on board
    WHERE i.Status = 'Arrived'
    GROUP BY i.FlightID, i.ArrivalTime, ao.AirportName, ad.AirportName
  )
END

--testing
UPDATE Flights
SET Status = 'Arrived'
WHERE FlightID BETWEEN 1 AND 10