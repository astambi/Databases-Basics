CREATE FUNCTION udf_GetRating (@productName nvarchar(25))
RETURNS varchar(20)
AS
BEGIN
  DECLARE @rating decimal(4, 2) = (
    SELECT AVG(f.Rate)
    FROM Feedbacks AS f
    JOIN Products AS p ON f.ProductId = p.Id
    WHERE p.Name = @productName
  );
  DECLARE @descrRating varchar(20);  
  IF(@rating < 5)                  SET @descrRating = 'Bad';
  ELSE IF(@rating BETWEEN 5 AND 8) SET @descrRating = 'Average';
  ELSE IF(@rating > 8)             SET @descrRating = 'Good';
  ELSE IF(@rating IS NULL)         SET @descrRating = 'No rating'; 
  RETURN @descrRating;
END

--testing
SELECT TOP 5 Id, Name, dbo.udf_GetRating(Name)
FROM Products
ORDER BY Id