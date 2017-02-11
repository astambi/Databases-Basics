CREATE PROC usp_DepositMoney (@accountId int, @depositAmount money)
AS
BEGIN
  BEGIN TRANSACTION
  UPDATE Accounts
  SET Balance += @depositAmount
  WHERE (Id = @accountId)
  
  IF (@@ROWCOUNT <> 1) 
    BEGIN
      ROLLBACK;
      RAISERROR ('Invalid account!', 16, 1);
      RETURN;
    END
  COMMIT;
END

--testing
EXEC usp_DepositMoney 1, 1000000;