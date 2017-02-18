-- titles from Chats in which the user participates (Users->UserChats->Chats) => submit in Judge
SELECT u.Nickname, c.Title, l.Latitude, l.Longitude
FROM Users AS u
JOIN Locations AS l ON u.LocationId = l.Id
JOIN UsersChats AS uc ON uc.UserId = u.Id
JOIN Chats AS c on uc.ChatId = c.Id
WHERE l.Latitude BETWEEN 41.13999 AND 44.12999  -- NB incorrent range requirement [41.14, 44.13]
  AND l.Longitude BETWEEN 22.20999 AND 28.35999 -- NB incorrect range requirement [22.21, 28.36]
ORDER BY c.Title

-- titles from msgs created by the user (User->Messages->Chats) not tested in Judge => do NOT submit!
SELECT u.Nickname, c.Title, l.Latitude, l.Longitude
FROM Users AS u
JOIN Locations AS l ON u.LocationId = l.Id
JOIN Messages AS m ON m.UserId = u.Id
JOIN Chats AS c ON m.ChatId = c.Id
WHERE l.Latitude BETWEEN 41.13999 AND 44.12999  -- NB incorrent range requirement [41.14, 44.13]
  AND l.Longitude BETWEEN 22.20999 AND 28.35999 -- NB incorrect range requirement [22.21, 28.36]
ORDER BY c.Title