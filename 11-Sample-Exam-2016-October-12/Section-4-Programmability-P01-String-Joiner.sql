CREATE FUNCTION udf_ConcatString (@str1 varchar(max), @str2 varchar(max))
RETURNS varchar(max)
AS
BEGIN
  RETURN CONCAT(REVERSE(@str1), REVERSE(@str2));
END

GO
--testing
SELECT dbo.udf_ConcatString('1234', '5678');