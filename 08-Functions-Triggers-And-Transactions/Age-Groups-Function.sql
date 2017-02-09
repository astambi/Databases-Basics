CREATE FUNCTION ufn_AgeGroups(@age int)
RETURNS varchar(10)
AS
BEGIN 
  DECLARE @lower int = (@Age-1)/10 * 10 + 1;
  IF(@Age >= 61) RETURN ('[61+]');
  IF(@Age <= 0)  RETURN ('[0-10]');
  RETURN CONCAT('[', @lower, '-', @lower + 9, ']');
END;
GO

SELECT
  dbo.ufn_AgeGroups(Age) AS AgeGroup,
  COUNT(*) AS WizardCount
FROM WizzardDeposits
GROUP BY dbo.ufn_AgeGroups(Age)