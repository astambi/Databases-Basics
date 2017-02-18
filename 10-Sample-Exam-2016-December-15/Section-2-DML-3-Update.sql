UPDATE Chats
SET Chats.StartDate = (
  SELECT MIN(m.SentOn)
  FROM Chats AS c
  JOIN Messages AS m ON m.ChatId = c.Id
  WHERE c.StartDate = Chats.StartDate
)
WHERE Id IN(
  SELECT c.Id
  FROM Chats AS c
  JOIN Messages AS m ON m.ChatId = c.Id
  WHERE c.StartDate > m.SentOn
)