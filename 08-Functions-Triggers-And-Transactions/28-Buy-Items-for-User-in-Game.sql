DECLARE @gameName nvarchar(50) = 'Edinburgh';
DECLARE @username nvarchar(50) = 'Alex';
DECLARE @userGameId int = (
  SELECT ug.Id 
  FROM UsersGames AS ug
  JOIN Users AS u ON ug.UserId = u.Id
  JOIN Games AS g ON ug.GameId = g.Id
  WHERE u.Username = @username AND g.Name = @gameName
);
DECLARE @availableCash money = (SELECT Cash FROM UsersGames WHERE Id = @userGameId);
DECLARE @purchasePrice money = (
  SELECT SUM(Price) FROM Items WHERE Name IN 
  ('Blackguard', 'Bottomless Potion of Amplification', 'Eye of Etlich (Diablo III)',
  'Gem of Efficacious Toxin', 'Golden Gorget of Leoric', 'Hellfire Amulet')
); 

-- begin transaction only if enough game cash to buy all requested items, 
-- validating min game level not required
IF (@availableCash >= @purchasePrice) 
BEGIN 
  BEGIN TRANSACTION  
  UPDATE UsersGames SET Cash -= @purchasePrice WHERE Id = @userGameId; 
  IF(@@ROWCOUNT <> 1) 
  BEGIN
    ROLLBACK; RAISERROR('Could not make payment', 16, 1); RETURN;
  END
  INSERT INTO UserGameItems (ItemId, UserGameId) 
  (SELECT Id, @userGameId FROM Items WHERE Name IN 
    ('Blackguard', 'Bottomless Potion of Amplification', 'Eye of Etlich (Diablo III)',
    'Gem of Efficacious Toxin', 'Golden Gorget of Leoric', 'Hellfire Amulet')) 
  IF((SELECT COUNT(*) FROM Items WHERE Name IN 
    ('Blackguard', 'Bottomless Potion of Amplification', 'Eye of Etlich (Diablo III)', 
	'Gem of Efficacious Toxin', 'Golden Gorget of Leoric', 'Hellfire Amulet')) <> @@ROWCOUNT)
  BEGIN
    ROLLBACK; RAISERROR('Could not buy items', 16, 1); RETURN;
  END	
  COMMIT;
END

-- select users in game with items
SELECT u.Username, g.Name, ug.Cash, i.Name AS [Item Name]
FROM UsersGames AS ug
JOIN Games AS g ON ug.GameId = g.Id
JOIN Users AS u ON ug.UserId = u.Id
JOIN UserGameItems AS ugi ON ug.Id = ugi.UserGameId
JOIN Items AS i ON i.Id = ugi.ItemId
WHERE g.Name = @gameName