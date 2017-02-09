CREATE FUNCTION ufn_Summarize(@text varchar(max), @length int)
RETURNS varchar(max)
AS
BEGIN
  DECLARE @result varchar(max);
  IF(len(@text) <= @length) SET @result = @text;
  ELSE                      SET @result = LEFT(@text, @length) + '...';
  RETURN @result;
END;
GO

SELECT FirstName, 
  dbo.ufn_Summarize(FirstName, 3)
FROM Employees