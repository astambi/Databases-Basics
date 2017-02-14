-- Stored procedure working only in SSMS but NOT in Judge! 
CREATE PROCEDURE usp_BuyItemsFromLevel (@minLevel int, @maxLevel int)
AS
BEGIN
  DECLARE @gameName nvarchar(50) = 'Safflower';
  DECLARE @username nvarchar(50) = 'Stamat';
  DECLARE @userGameId int = (
    SELECT ug.Id 
    FROM UsersGames AS ug
    JOIN Users AS u ON ug.UserId = u.Id
    JOIN Games AS g ON ug.GameId = g.Id
    WHERE u.Username = @username AND g.Name = @gameName
  );
  DECLARE @userGameLevel int = (SELECT Level FROM UsersGames WHERE Id = @userGameId);	
  DECLARE @availableCash money = (SELECT Cash FROM UsersGames WHERE Id = @userGameId);
  DECLARE @itemsCost money = (SELECT SUM(Price) FROM Items WHERE MinLevel BETWEEN @minLevel AND @maxLevel);

/* begin transaction only if: enough game cash to buy all requested items & 
   high enough user game level to meet item minlevel requirement */
  IF (@availableCash >= @itemsCost AND @userGameLevel >= @maxLevel) 
  BEGIN 
    BEGIN TRANSACTION  
    UPDATE UsersGames SET Cash -= @itemsCost WHERE Id = @userGameId; 
    IF(@@ROWCOUNT <> 1) 
    BEGIN
      ROLLBACK; RAISERROR('Could not make payment', 16, 1); --RETURN;
    END
    ELSE
    BEGIN
      INSERT INTO UserGameItems (ItemId, UserGameId) 
      (SELECT Id, @userGameId FROM Items WHERE MinLevel BETWEEN @minLevel AND @maxLevel) 
      IF((SELECT COUNT(*) FROM Items WHERE MinLevel BETWEEN @minLevel AND @maxLevel) <> @@ROWCOUNT)
      BEGIN
        ROLLBACK; RAISERROR('Could not buy items', 16, 1); --RETURN;
      END	
      ELSE COMMIT;
    END
  END
END;
GO

-- execute procedure for both itemlevel ranges 
EXEC usp_BuyItemsFromLevel 11, 12;
EXEC usp_BuyItemsFromLevel 19, 21;

-- select items in game
SELECT i.Name AS [Item Name]
FROM UserGameItems AS ugi
JOIN Items AS i ON i.Id = ugi.ItemId
JOIN UsersGames AS ug ON ug.Id = ugi.UserGameId
JOIN Games AS g ON g.Id = ug.GameId
WHERE g.Name = 'Safflower'
ORDER BY [Item Name]