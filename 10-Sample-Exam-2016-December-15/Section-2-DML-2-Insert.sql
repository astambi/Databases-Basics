INSERT INTO Messages (Content, SentOn, ChatId, UserId)
(
  SELECT 
    CONCAT(u.Age, '-', u.Gender, '-', l.Latitude, '-', l.Longitude),
    GETDATE(), 
    CEILING(
    CASE 
      WHEN u.Gender = 'F' THEN SQRT(u.Age * 2)
      WHEN u.Gender = 'M' THEN POWER(u.Age / 18, 3)
      -- NB! No casting to float/ numeric !
    END),
    u.Id
    FROM Users AS u
    INNER JOIN Locations AS l ON u.LocationId = l.Id
    WHERE u.Id BETWEEN 10 AND 20
)