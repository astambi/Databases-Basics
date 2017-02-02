SELECT TOP 1
  (SELECT DepositAmount FROM WizzardDeposits WHERE Id = (SELECT MIN(Id) FROM WizzardDeposits)) - 
  (SELECT DepositAmount FROM WizzardDeposits WHERE Id = (SELECT MAX(Id) FROM WizzardDeposits)) 
  AS SumDifference
FROM WizzardDeposits

-- solution with LEAD
SELECT SUM(DepoDifference) AS SumDifference
FROM 
  (SELECT
     FirstName AS [Host Wizard], 
     DepositAmount AS [Host Wizard Deposit],
     LEAD(FirstName) OVER (ORDER BY Id) AS [Guest Wizzard],
     LEAD(DepositAmount) OVER (ORDER BY Id) AS [Guest Wizard Deposit],
     DepositAmount - LEAD(DepositAmount) OVER (ORDER BY Id) AS [DepoDifference]
   FROM WizzardDeposits) AS Differences
   
-- solution with LAG
SELECT SUM(DepoDifference) AS SumDifference
FROM 
  (SELECT
     LAG(FirstName) OVER (ORDER BY Id) AS [Host Wizard],
     LAG(DepositAmount) OVER (ORDER BY Id) AS [Host Wizard Deposit],
     FirstName AS [Guest Wizard], 
     DepositAmount AS [Guest Wizard Deposit],
	 LAG(DepositAmount) OVER (ORDER BY Id) - DepositAmount AS [DepoDifference]
   FROM WizzardDeposits) AS Differences

-- solution with CURSOR
DECLARE @currentDeposit DECIMAL(8,2)
DECLARE @previousDeposit DECIMAL(8,2)
DECLARE @sumDifferences DECIMAL(8,2) = 0
DECLARE wizardCursor CURSOR FOR SELECT DepositAmount FROM WizzardDeposits

OPEN wizardCursor
FETCH NEXT FROM wizardCursor INTO @currentDeposit
WHILE (@@FETCH_STATUS = 0)
BEGIN
  IF (@previousDeposit IS NOT NULL)
  BEGIN
    SET @sumDifferences += @previousDeposit - @currentDeposit
  END
  SET @previousDeposit = @currentDeposit
  FETCH NEXT FROM wizardCursor INTO @currentDeposit
END
CLOSE wizardCursor
DEALLOCATE wizardCursor

SELECT @sumDifferences AS SumDifference
