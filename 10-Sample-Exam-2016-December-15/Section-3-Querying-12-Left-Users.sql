SELECT Id AS Id, ChatId, UserId
FROM Messages
WHERE ChatId = 17
  AND (UserId NOT IN (SELECT UserId FROM UsersChats WHERE ChatId = 17) -- user not in chat
       OR UserId IS NULL) -- deleted user with msgs !
ORDER BY Id DESC
-- or
SELECT m.Id, m.ChatId, m.UserId 
FROM Messages AS m
LEFT JOIN UsersChats AS uc 
ON uc.ChatId = m.ChatId AND m.UserId = uc.UserId -- ! both chat & user ref
WHERE m.ChatId = 17 AND uc.UserId IS NULL -- not in chat (null uc.UserId) or deleted (null m.UserId)
ORDER BY m.Id DESC