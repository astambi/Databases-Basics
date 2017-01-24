SELECT TOP (50) 
	Name, 
	LEFT(CONVERT(varchar, Start, 120), 10) AS Start				-- YYYY-MM-DD hh:mi:ss
	--REPLACE(CONVERT(varchar, Start, 111), '/', '-') AS Start	-- YYYY/MM/DD
	--REPLACE(CONVERT(varchar, Start, 102), '.', '-') AS Start	-- YYYY.MM.DD
FROM Games
WHERE YEAR(Start) IN (2011, 2012)
ORDER BY Games.Start, Name