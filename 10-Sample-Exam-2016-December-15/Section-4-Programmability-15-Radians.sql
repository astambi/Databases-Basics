CREATE FUNCTION udf_GetRadians (@deg float)
RETURNS float
AS
BEGIN
  RETURN @deg * PI() / 180
END

GO
--testing
SELECT dbo.udf_GetRadians(22.12) AS Radians