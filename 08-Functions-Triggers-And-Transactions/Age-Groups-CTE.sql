WITH CTE_AgeGroups (AgeGroup) AS (
  SELECT 
    IIF(Age >= 61, '[61+]', IIF(Age = 0, '[0-10]', 
	  CONCAT('[',(Age-1)/10 * 10 + 1,'-', (Age-1)/10 * 10 + 10, ']'))) 
  FROM WizzardDeposits
)
SELECT AgeGroup, COUNT(*) AS WizardCount
FROM CTE_AgeGroups
GROUP BY AgeGroup