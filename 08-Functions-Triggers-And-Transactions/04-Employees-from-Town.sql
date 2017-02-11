CREATE PROC usp_GetEmployeesFromTown (@townName varchar(max))
AS
  SELECT e.FirstName, e.LastName
  FROM Employees AS e 
  JOIN Addresses AS a ON a.AddressID = e.AddressID
  JOIN Towns as t ON t.TownID = a.TownID
  WHERE Name = @townName

--testing
EXEC usp_GetEmployeesFromTown 'Sofia'