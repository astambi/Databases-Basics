--CREATE TABLE MessageLogs(
--  Id int NOT NULL UNIQUE, -- IDENITITY not used in Judge
--  Content varchar(200),
--  SentOn date,
--  ChatId int NOT NULL,
--  UserId int NOT NULL,
--  CONSTRAINT PK_MessageLogs PRIMARY KEY (Id),
--  CONSTRAINT FK_MessageLogs_Chats FOREIGN KEY (ChatId) REFERENCES Chats(Id),
--  CONSTRAINT FK_MessageLogs_Users FOREIGN KEY (UserId) REFERENCES Users(Id)
--)

CREATE TRIGGER tr_LogMessages ON Messages FOR DELETE
AS
BEGIN
  INSERT INTO MessageLogs (Id, Content, SentOn, ChatId, UserId)
  (SELECT Id, Content, SentOn, ChatId, UserId FROM deleted) -- use the deleted msgId
END

GO
--testing
DELETE FROM [Messages] WHERE [Messages].Id = 1
SELECT * FROM [Messages] WHERE Id = 1
SELECT * FROM MessageLogs WHERE Id = 1