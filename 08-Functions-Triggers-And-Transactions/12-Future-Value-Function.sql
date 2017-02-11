CREATE FUNCTION ufn_CalculateFutureValue (@sum money, @annualIntRate float, @years int)
RETURNS money
AS
BEGIN
  RETURN @sum * POWER(1 + @annualIntRate, @years);  
END;

-- testing - do not submit in Judge
SELECT dbo.ufn_CalculateFutureValue(1000, 0.10, 5) AS FV