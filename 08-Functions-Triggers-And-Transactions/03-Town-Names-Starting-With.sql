CREATE PROC usp_GetTownsStartingWith (@startingWith varchar(max))
AS
  SELECT Name AS Town
  FROM Towns
  WHERE Name LIKE CONCAT(@startingWith, '%')

--testing
EXEC usp_GetTownsStartingWith 'b'