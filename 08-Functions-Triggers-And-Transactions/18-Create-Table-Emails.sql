--CREATE TABLE NotificationEmails (
--  Id int NOT NULL IDENTITY, 
--  Recipient int NOT NULL, 
--  Subject varchar(200) NOT NULL, 
--  Body varchar(200) NOT NULL,
--  CONSTRAINT PK_NotificationEmails PRIMARY KEY (Id),
--  CONSTRAINT FK_NotificationEmails_Accounts FOREIGN KEY (Recipient) REFERENCES Accounts(Id),
--)

CREATE TRIGGER tr_LogsNotificationEmails ON Logs FOR INSERT
AS
BEGIN
  DECLARE @recipient int = (SELECT AccountId FROM inserted);
  DECLARE @oldBalance money = (SELECT OldSum FROM inserted);
  DECLARE @newBalance money = (SELECT NewSum FROM inserted);
  DECLARE @subject varchar(200) = CONCAT('Balance change for account: ', @recipient);
  DECLARE @body varchar(200) = 
    CONCAT('On ', GETDATE(), ' your balance was changed from ', @oldBalance, ' to ', @newBalance, '.');  
  INSERT INTO NotificationEmails (Recipient, Subject, Body) 
  VALUES (@recipient, @subject, @body)
END
-- OR
CREATE TRIGGER tr_LogsNotificationEmails ON Logs FOR INSERT
AS
BEGIN  
  INSERT INTO NotificationEmails (Recipient, Subject, Body) 
  (SELECT AccountId, 
     CONCAT('Balance change for account: ', AccountId),
     CONCAT('On ', GETDATE(), ' your balance was changed from ', OldSum, ' to ', NewSum, '.')
   FROM inserted)
END

-- testing
UPDATE Accounts
SET Balance += 1000
WHERE Id = 1