SELECT c.Title, c.IsActive
FROM Chats AS c
WHERE (c.IsActive = 0 AND LEN(c.Title) < 5 ) -- inactive chat!
   OR c.Title LIKE '__tl%'
ORDER BY c.Title DESC