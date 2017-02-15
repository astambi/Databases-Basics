SELECT DISTINCT 
  c.CustomerID, 
  CONCAT(c.FirstName, ' ', c.LastName)  AS [FullName],
  2016 - YEAR(c.DateOfBirth) AS Age
FROM Tickets AS ti
JOIN Customers AS c ON ti.CustomerID = c.CustomerID
JOIN Flights AS f ON ti.FlightID = f.FlightID
WHERE f.Status = 'Departing'
ORDER BY Age, c.CustomerID