TRANSACTION / TRAN

DECLARE @withdrawAmount money = 10, @account int = 1;

BEGIN TRANSACTION

UPDATE Accounts 
SET Balance -= @withdrawAmount
WHERE Id = @account

IF @@ROWCOUNT <> 1 -- Affected rows are different than one.
  BEGIN
    ROLLBACK;
    RAISERROR('Invalid account!', 16, 1);
    RETURN;
  END
COMMIT;