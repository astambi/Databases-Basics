CREATE PROCEDURE usp_PurchaseTicket 
(@CustomerID int, @FlightID int, @TicketPrice numeric(8, 2), @Class varchar(6), @Seat varchar(5))
AS
BEGIN
  --CustomerID , FlightID, Class and Seat will always be valid, and existent in the database
  IF(@TicketPrice < 0)
    BEGIN
      RAISERROR('Invalid ticket price', 16,1); RETURN;
    END
  IF(@TicketPrice > ISNULL((SELECT Balance FROM CustomerBankAccounts WHERE CustomerID = @CustomerID), 0)) -- accBalance
    BEGIN
      RAISERROR('Insufficient bank account balance for ticket purchase.', 16, 1); RETURN;
    END

  BEGIN TRANSACTION
  DECLARE @TicketID int = ISNULL((SELECT MAX(TicketID) FROM Tickets), 0) + 1;
  -- insert tickets
  INSERT INTO Tickets (TicketID, CustomerID, FlightID, Price, Class, Seat) 
  VALUES (@TicketID, @CustomerID, @FlightID, @TicketPrice, @Class, @Seat)
  IF(@@ROWCOUNT <> 1)
    BEGIN
      ROLLBACK; RAISERROR('Unsuccessful ticket purchase', 16, 1); RETURN;
    END  
  -- update bank account balance
  UPDATE CustomerBankAccounts
  SET Balance -= @TicketPrice
  WHERE CustomerID = @CustomerID
  IF(@@ROWCOUNT <> 1)
    BEGIN
      ROLLBACK; RAISERROR('Unsuccessful ticket purchase', 16, 1); RETURN;
    END  
  COMMIT
END

--testing
EXEC usp_PurchaseTicket 1, 1, 1000.00, 'First', '10-D'; -- ok
EXEC usp_PurchaseTicket 1, 1, -100.00, 'First', '10-D'; -- error ticketPrice < 0
EXEC usp_PurchaseTicket 1, 1, 1000000, 'First', '10-D'; -- error ticketPrice > accBalance