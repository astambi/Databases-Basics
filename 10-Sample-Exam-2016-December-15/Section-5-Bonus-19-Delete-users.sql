CREATE TRIGGER tr_DeleteUser ON Users 
INSTEAD OF DELETE
AS
BEGIN  
  -- remove NOT NULL constraint for UserId in Messages
  ALTER TABLE Messages
  ALTER COLUMN UserId int NULL  

  -- set UserId in Messages to NULL for all users to be deleted
  UPDATE Messages
  SET UserId = NULL  
  WHERE UserId IN (SELECT Id FROM deleted)  

  -- delete user-chat entries in mapping table UsesChats for all users to be deleted
  DELETE FROM UsersChats
  WHERE UserId IN (SELECT Id FROM deleted)  
  
  -- delete 1-to-1 relation to user Credentials (not required in Judge)
  UPDATE Users
  SET CredentialId = NULL
  WHERE Id IN (SELECT Id FROM deleted)
  
  DELETE FROM Credentials
  WHERE Id IN (SELECT CredentialId FROM deleted)
  
  -- delete users
  DELETE FROM Users
  WHERE Users.Id = (SELECT Id FROM deleted)  
END

GO
--testing
DELETE FROM Users WHERE Users.Id = 1

SELECT * FROM Users WHERE Id = 1
SELECT * FROM Messages WHERE UserId = 1