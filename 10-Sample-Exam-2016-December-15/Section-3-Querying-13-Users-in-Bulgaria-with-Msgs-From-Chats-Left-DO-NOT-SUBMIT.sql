SELECT DISTINCT
  CASE 
    WHEN l1.Latitude BETWEEN 41.14 AND 44.13 AND l1.Longitude BETWEEN 22.21 AND 28.36 THEN u1.Nickname
	WHEN l2.Latitude BETWEEN 41.14 AND 44.13 AND l2.Longitude BETWEEN 22.21 AND 28.36 THEN u2.Nickname
  END AS Nickname,  
  c.Title, 
  CASE 
    WHEN l1.Latitude BETWEEN 41.14 AND 44.13 AND l1.Longitude BETWEEN 22.21 AND 28.36 THEN l1.Latitude
	WHEN l2.Latitude BETWEEN 41.14 AND 44.13 AND l2.Longitude BETWEEN 22.21 AND 28.36 THEN l2.Latitude
  END AS Latitude,
  CASE 
    WHEN l1.Latitude BETWEEN 41.14 AND 44.13 AND l1.Longitude BETWEEN 22.21 AND 28.36 THEN l1.Longitude
	WHEN l2.Latitude BETWEEN 41.14 AND 44.13 AND l2.Longitude BETWEEN 22.21 AND 28.36 THEN l2.Longitude
  END AS Longitude
FROM Chats AS c
FULL JOIN UsersChats AS uc ON c.Id = uc.ChatId
FULL JOIN Messages AS m ON c.Id = m.ChatId
FULL JOIN Users AS u1 ON u1.Id = uc.UserId
FULL JOIN Users AS u2 ON u2.Id = m.UserId
FULL JOIN Locations AS l1 ON l1.Id = u1.LocationId
FULL JOIN Locations AS l2 ON l2.Id = u2.LocationId
WHERE l1.Latitude BETWEEN 41.14 AND 44.13 AND l1.Longitude BETWEEN 22.21 AND 28.36
   OR l2.Latitude BETWEEN 41.14 AND 44.13 AND l2.Longitude BETWEEN 22.21 AND 28.36
ORDER BY c.Title

-- 1. msg titles from Chats in which the user participates (Chats via UsersChats) AND
-- 2. msg titles from Msgs created by the user (Chats via Messages)
-- Do NOT submit in Judge - only type 1 msgs tested in Judge
-- NB incorrent range requirement for Latitude [41.14, 44.13] & Longitude [22.21, 28.36]