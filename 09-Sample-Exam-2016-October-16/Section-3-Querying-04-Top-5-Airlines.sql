SELECT DISTINCT TOP 5
  a.AirlineID, a.AirlineName, a.Nationality, a.Rating
FROM Airlines AS a
JOIN Flights AS f ON f.AirlineID = a.AirlineID
ORDER BY a.Rating DESC, a.AirlineID