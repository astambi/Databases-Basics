SELECT 
	Name AS Game, 
	IIF(DATEPART(HH, Start) >= 18, 'Evening', 
		IIF(DATEPART(HH, Start) >= 12, 'Afternoon', 'Morning')) 
		AS [Part of the Day], 
	IIF(Duration IS NULL, 'Extra Long',
		IIF(Duration > 6, 'Long', 
			IIF(Duration >= 4, 'Short', 'Extra Short'))) 
		AS Duration
FROM Games
ORDER BY Game, Duration, [Part of the Day]