SELECT TOP (1) WITH TIES 
  c.Title, m.Content
FROM Chats AS c
LEFT JOIN Messages AS m ON c.Id = m.ChatId
ORDER BY c.StartDate DESC, m.SentOn