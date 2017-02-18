CREATE PROCEDURE usp_CustomersWithUnexpiredLoans (@CustomerID int)
AS
BEGIN
  SELECT c.CustomerID, c.FirstName, l.LoanID
  FROM Customers AS c
  JOIN Loans AS l ON l.CustomerID = c.CustomerID
  WHERE l.ExpirationDate IS NULL AND c.CustomerID = @CustomerID
END

GO
--testing
EXEC usp_CustomersWithUnexpiredLoans @CustomerID = 9