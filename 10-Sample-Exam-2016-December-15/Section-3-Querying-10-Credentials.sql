SELECT u.Nickname, c.Email, c.Password
FROM Users AS u
JOIN Credentials AS c ON u.CredentialId = c.Id
WHERE c.Email LIKE '%co.uk'
ORDER BY c.Email