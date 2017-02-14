DECLARE @gameName nvarchar(50) = 'Safflower';
DECLARE @username nvarchar(50) = 'Stamat';
DECLARE @userGameId int = (
  SELECT ug.Id 
  FROM UsersGames AS ug
  JOIN Users AS u ON ug.UserId = u.Id
  JOIN Games AS g ON ug.GameId = g.Id
  WHERE u.Username = @username AND g.Name = @gameName
) 
DECLARE @purchasePrice money, @availableCash money;

-- task 3 for LEVEL 11-12
BEGIN TRANSACTION  
SET @purchasePrice = (SELECT SUM(Price) FROM Items WHERE MinLevel IN (11, 12));
SET @availableCash = (SELECT Cash FROM UsersGames WHERE Id = @userGameId);
IF(@availableCash >= @purchasePrice) -- CHECK constraint in DB gives compile time error in Judge
BEGIN 
	-- reduce cash with price paid for item
	UPDATE UsersGames 
	SET Cash -= @purchasePrice
	WHERE Id = @userGameId

	IF(@@ROWCOUNT <> 1)
	  BEGIN
		ROLLBACK; 
		RAISERROR('Insufficient cash', 16, 1);
		RETURN;
	  END 
	-- add items to usergame
	INSERT INTO UserGameItems (ItemId, UserGameId) 
	(SELECT Id, @userGameId FROM Items WHERE MinLevel IN (11, 12))

	IF((SELECT COUNT(*) FROM Items WHERE MinLevel IN (11, 12)) <> @@ROWCOUNT)
	BEGIN
	  ROLLBACK;
	  RAISERROR('Could not buy items', 16, 1);
	  RETURN;
	END
	COMMIT;
END

-- task 3 for LEVEL 19-21
BEGIN TRANSACTION  
SET @purchasePrice = (SELECT SUM(Price) FROM Items WHERE MinLevel IN (19, 20, 21));
SET @availableCash = (SELECT Cash FROM UsersGames WHERE Id = @userGameId);
IF(@availableCash >= @purchasePrice) 
BEGIN 
	-- reduce cash with price paid for item
	UPDATE UsersGames 
	SET Cash -= @purchasePrice
	WHERE Id = @userGameId

	IF(@@ROWCOUNT <> 1)
	  BEGIN
		ROLLBACK; 
		RAISERROR('Insufficient cash', 16, 1);
		RETURN;
	  END 
	-- add items to usergame
	INSERT INTO UserGameItems (ItemId, UserGameId) 
	(SELECT Id, @userGameId FROM Items WHERE MinLevel IN (19, 20, 21))

	IF((SELECT COUNT(*) FROM Items WHERE MinLevel IN (19, 20, 21)) <> @@ROWCOUNT)
	BEGIN
	  ROLLBACK;
	  RAISERROR('Could not buy items', 16, 1);
	  RETURN;
	END
	COMMIT;
END

-- task 4
SELECT i.Name AS [Item Name]
FROM UserGameItems AS ugi
JOIN Items AS i ON i.Id = ugi.ItemId
JOIN UsersGames AS ug ON ug.Id = ugi.UserGameId
JOIN Games AS g ON g.Id = ug.GameId
WHERE g.Name = @gameName
ORDER BY [Item Name]