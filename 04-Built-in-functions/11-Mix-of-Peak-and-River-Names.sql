SELECT 
	PeakName, RiverName, 
	LOWER(SUBSTRING(PeakName, 1, LEN(PeakName) - 1) + RiverName) AS Mix
FROM Peaks JOIN Rivers
ON RIGHT(Peaks.PeakName, 1) = LEFT(Rivers.RiverName, 1)
ORDER BY Mix