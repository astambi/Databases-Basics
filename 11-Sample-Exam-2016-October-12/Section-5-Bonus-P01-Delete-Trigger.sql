--CREATE TABLE AccountLogs(
--  AccountID INT,
--  AccountNumber CHAR(12) NOT NULL,
--  StartDate DATE NOT NULL,
--  CustomerID INT NOT NULL,
--  CONSTRAINT PK_AccountLogs PRIMARY KEY(AccountID),
--  CONSTRAINT FK_AccountLogs_Customers FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID)
--)

CREATE TRIGGER tr_DeleteAccount ON Accounts 
INSTEAD OF DELETE
AS
BEGIN
  DELETE FROM EmployeesAccounts
  WHERE AccountID IN (SELECT AccountID FROM deleted)

  DELETE FROM Accounts
  WHERE AccountID IN (SELECT AccountID FROM deleted)

  INSERT INTO AccountLogs (AccountID, AccountNumber, StartDate, CustomerID)
  (SELECT AccountID, AccountNumber, StartDate, CustomerID FROM deleted)
END

--testing
DELETE FROM [dbo].[Accounts] WHERE CustomerID = 4

SELECT * FROM Accounts WHERE CustomerID = 4
SELECT * FROM AccountLogs WHERE CustomerID = 4