CREATE PROCEDURE udp_SendMessage (@UserId int, @ChatId int, @Content varchar(200))
AS
BEGIN
  IF(@ChatId NOT IN (SELECT ChatId FROM UsersChats WHERE UserId = @UserId))
    RAISERROR('There is no chat with that user!', 16, 1);
  ELSE
    BEGIN
      INSERT INTO Messages (UserId, ChatId, Content, SentOn) 
      VALUES (@UserId, @ChatId, @Content, GETDATE())
    END
END

GO
--testing
EXEC dbo.udp_SendMessage 19, 17, 'Awesome';

SELECT * FROM Messages WHERE UserId = 19 AND ChatId = 17;