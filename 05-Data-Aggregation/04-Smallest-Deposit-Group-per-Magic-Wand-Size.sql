SELECT DepositGroup
FROM WizzardDeposits
GROUP BY DepositGroup
HAVING AVG(MagicWandSize) = -- min AverageWandSize per DepositGroup
  (SELECT TOP 1
  AVG(MagicWandSize) AS AverageWandSize
  FROM WizzardDeposits
  GROUP BY DepositGroup
  ORDER BY AverageWandSize)

-- another solution
SELECT TOP 1 WITH TIES DepositGroup
FROM WizzardDeposits
GROUP BY DepositGroup
ORDER BY AVG(MagicWandSize)