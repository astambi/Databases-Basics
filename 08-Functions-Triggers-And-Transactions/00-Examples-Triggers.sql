TRIGGER FOR / TRIGGER INSTEAD OF

-- CREATE TRIGGER FOR
CREATE TRIGGER tr_TownsUpdate ON Towns FOR UPDATE
AS
  IF(EXISTS(SELECT * FROM inserted WHERE Name IS NULL) OR -- system account
     EXISTS(SELECT * FROM inserted WHERE LEN(Name) = 0))
    BEGIN
      RAISERROR('Town name cannot be empty.', 16, 1);
      ROLLBACK TRAN;
      RETURN;
    END

UPDATE Towns SET Name = '' WHERE TownId = 1 -- error

--CREATE TRIGGER INSTEAD OF
CREATE TRIGGER tr_AccountsDelete ON Accounts INSTEAD OF DELETE
AS
  UPDATE a 
  SET Active = 'N'
  FROM Accounts AS a 
  JOIN DELETED AS d ON d.Username = a.Username -- system account
  WHERE a.Active = 'Y'
  
CREATE TABLE Accounts(
  Username varchar(10) NOT NULL PRIMARY KEY,
  Password varchar(20) NOT NULL,
  Active char NOT NULL DEFAULT 'Y'
)
INSERT INTO Accounts VALUES
  ('AAA', 123, DEFAULT), ('BBB', 123, DEFAULT), ('CCC', 123, DEFAULT)
  
DELETE FROM Accounts WHERE Username = 'AAA' -- inactive (trigger logic)

-- ALTER TRIGGER
ALTER TRIGGER tr_AccountsDelete [...]

-- DROP TRIGGER
DROP TRIGGER tr_AccountsDelete
DELETE FROM Accounts WHERE Username = 'AAA' -- deleted