SELECT
  IIF(Age >= 61, '[61+]', 
    IIF(Age = 0, '[0-10]', 
	  CONCAT('[',(Age-1)/10 * 10 + 1,'-', (Age-1)/10 * 10 + 10, ']'))) AS AgeGroup,
  COUNT(Age) AS WizardCount
FROM WizzardDeposits
GROUP BY 
  IIF(Age >= 61, '[61+]', 
    IIF(Age = 0, '[0-10]', 
	  CONCAT('[',(Age-1)/10 * 10 + 1,'-', (Age-1)/10 * 10 + 10, ']')))
HAVING COUNT(Age) > 0
ORDER BY AgeGroup