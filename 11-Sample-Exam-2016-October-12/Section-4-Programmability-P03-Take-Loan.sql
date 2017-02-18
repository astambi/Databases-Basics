CREATE PROCEDURE usp_TakeLoan (@CustomerID int, @LoanAmount decimal(10,2), @Interest decimal(10,2), @StartDate date)
AS
BEGIN
  BEGIN TRANSACTION
  INSERT INTO Loans (CustomerID, Amount, Interest, StartDate, ExpirationDate)
  VALUES (@CustomerID, @LoanAmount, @Interest, @StartDate, NULL)

  IF(@LoanAmount NOT BETWEEN 0.01 AND 100000)
  BEGIN
    RAISERROR('Invalid Loan Amount.', 16,1); ROLLBACK; 
  END
  ELSE COMMIT;
END

GO
--testing
EXEC usp_TakeLoan @CustomerID = 1, @LoanAmount = 500, @Interest = 1, @StartDate='20160915'