SELECT DepositGroup
FROM WizzardDeposits
GROUP BY DepositGroup
HAVING AVG(MagicWandSize) = -- min AverageWandSize per DepositGroup
  (SELECT TOP 1
  AVG(MagicWandSize) AS AverageWandSize
  FROM WizzardDeposits
  GROUP BY DepositGroup
  ORDER BY AverageWandSize)

-- solution WITH TIES
SELECT TOP 1 WITH TIES DepositGroup
FROM WizzardDeposits
GROUP BY DepositGroup
ORDER BY AVG(MagicWandSize)

-- another solution
SELECT DepositGroup
FROM WizzardDeposits
GROUP BY DepositGroup
HAVING AVG(MagicWandSize) = 
  (SELECT MIN(AvWandSizes.AvWandSize)
   FROM 
     (SELECT DepositGroup, AVG(MagicWandSize) AS AvWandSize
      FROM WizzardDeposits
      GROUP BY DepositGroup) AS AvWandSizes)
