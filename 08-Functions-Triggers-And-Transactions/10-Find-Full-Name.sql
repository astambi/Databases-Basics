CREATE PROC usp_GetHoldersFullName
AS
  SELECT CONCAT(FirstName, ' ', LastName) AS [Full Name]
  FROM AccountHolders

-- testing
EXEC usp_GetHoldersFullName