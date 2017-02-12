CREATE FUNCTION udf_ProjectDurationWeeks (@StartDate datetime, @EndDate datetime)
RETURNS int
AS
  BEGIN
    DECLARE @projectWeeks int;
    IF(@EndDate IS NULL) SET @EndDate = GETDATE();
    SET @projectWeeks = DATEDIFF(WEEK, @StartDate, @EndDate);
    RETURN @projectWeeks;
  END;
GO

SELECT ProjectID, StartDate, EndDate, 
  dbo.udf_ProjectDurationWeeks(StartDate, EndDate) AS ProjectWeeks
FROM Projects
ORDER BY ProjectWeeks DESC