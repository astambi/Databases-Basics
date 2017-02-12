SELECT 
  RIGHT(Email, LEN(Email) - CHARINDEX('@', Email)) AS [Email Provider], 
  COUNT(*) AS [Number of Users]
FROM Users
GROUP BY RIGHT(Email, LEN(Email) - CHARINDEX('@', Email))
ORDER BY [Number of Users] DESC, [Email Provider]