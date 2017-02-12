SELECT g.Name AS Game, gt.Name AS [Game Type],
  u.Username, ug.Level, ug.Cash, c.Name AS Character
FROM UsersGames AS ug
  JOIN Games AS g ON ug.GameId = g.Id
  JOIN GameTypes AS gt ON g.GameTypeId = gt.Id
  JOIN Users AS u ON ug.UserId = u.Id
  JOIN Characters AS c ON ug.CharacterId = c.Id
ORDER BY ug.Level DESC, u.Username, Game