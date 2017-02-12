SELECT u.Username, g.Name AS Game,
  COUNT(ugi.ItemId) AS [Items Count],
  SUM(i.Price) AS [Items Price]
FROM UsersGames AS ug
  JOIN Users AS u ON ug.UserId = u.Id
  JOIN Games AS g ON ug.GameId = g.Id
  JOIN UserGameItems AS ugi ON ugi.UserGameId = ug.Id -- NB! ug.Id <> g.Id
  JOIN Items AS i ON ugi.ItemId = i.Id
GROUP BY u.Username, g.Name
HAVING COUNT(ugi.ItemId) >= 10
ORDER BY
  [Items Count] DESC, [Items Price] DESC, u.Username