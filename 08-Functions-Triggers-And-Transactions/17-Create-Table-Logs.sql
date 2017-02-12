--CREATE TABLE Logs (
--  LogId int NOT NULL IDENTITY, 
--  AccountId int NOT NULL, 
--  OldSum money NOT NULL, 
--  NewSum money NOT NULL,
--  CONSTRAINT PK_Logs PRIMARY KEY (LogId),
--  CONSTRAINT FK_Logs_Accounts FOREIGN KEY (AccountId) REFERENCES Accounts(Id)
--)

CREATE TRIGGER tr_AccountBalanceChange ON Accounts FOR UPDATE
AS
BEGIN
  DECLARE @accountId int = (SELECT Id FROM inserted);
  DECLARE @oldBalance money = (SELECT Balance FROM deleted);
  DECLARE @newBalance money = (SELECT Balance FROM inserted);
  IF(@newBalance <> @oldBalance)
    INSERT INTO Logs VALUES (@accountId, @oldBalance, @newBalance);
END
--OR
CREATE TRIGGER tr_AccountBalanceChange ON Accounts FOR UPDATE
AS
BEGIN
  INSERT INTO Logs (AccountId, OldSum, NewSum)
  (SELECT ins.Id, del.Balance, ins.Balance
   FROM inserted AS ins
   JOIN deleted AS del ON ins.Id = del.Id
   WHERE ins.Balance <> del.Balance)
END

-- testing
UPDATE Accounts
SET Balance += 1000
WHERE Id = 1