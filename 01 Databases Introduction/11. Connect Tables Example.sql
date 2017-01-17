SELECT 
	m.Id,
	m.Name, 
	t.Name AS Town
FROM Minions m
LEFT JOIN Towns t ON t.Id = m.TownId