CREATE PROCEDURE usp_SubmitReview (@CustomerID int, @ReviewContent varchar(255), @ReviewGrade int, @AirlineName varchar(30))
AS
BEGIN
  DECLARE @AirlineID int = (SELECT AirlineID FROM Airlines WHERE AirlineName = @AirlineName);
  IF(@AirlineID IS NULL)
    BEGIN
      RAISERROR('Airline does not exist.', 16, 1); RETURN;
    END
  IF(@ReviewGrade < 0 OR @ReviewGrade > 10)
    BEGIN
      RAISERROR('Invalid review grade.', 16, 1); RETURN;
    END
  -- CustomerID will always be valid and existent in the database	
  DECLARE @ReviewID int = ISNULL((SELECT MAX(ReviewID) FROM CustomerReviews), 0) + 1;
  INSERT INTO CustomerReviews (ReviewID, CustomerID, ReviewContent, ReviewGrade, AirlineID)
  VALUES (@ReviewID, @CustomerID, @ReviewContent, @ReviewGrade, @AirlineID)
END

-- testing
EXEC usp_SubmitReview 1, 'Superb!', 10, 'Anna Airport'; -- error airline
EXEC usp_SubmitReview 1, 'Superb!', 11, 'Sofia Air';    -- error review grade
EXEC usp_SubmitReview 1, 'Superb!', 10, 'Sofia Air';