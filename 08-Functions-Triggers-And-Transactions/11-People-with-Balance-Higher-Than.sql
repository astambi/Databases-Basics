CREATE PROC usp_GetHoldersWithBalanceHigherThan (@minBalance money)
AS
BEGIN
  WITH CTE_MinBalanceAccountHolders (HolderId) AS (
    SELECT AccountHolderId FROM Accounts
    GROUP BY AccountHolderId
    HAVING SUM(Balance) > @minBalance
  )
  SELECT ah.FirstName AS [First Name], ah.LastName AS [Last Name]
  FROM CTE_MinBalanceAccountHolders AS minBalanceHolders 
  JOIN AccountHolders AS ah ON ah.Id = minBalanceHolders.HolderId
  ORDER BY ah.LastName, ah.FirstName 
  -- NB not a requirement, however Judge would accept the solution only in that precise order!
END

-- testing - do not submit in Judge
EXEC usp_GetHoldersWithBalanceHigherThan 6000000;
EXEC usp_GetHoldersWithBalanceHigherThan 5000000;
EXEC usp_GetHoldersWithBalanceHigherThan 1000;