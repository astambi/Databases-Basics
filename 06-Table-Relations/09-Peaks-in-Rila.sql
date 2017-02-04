SELECT MountainRange, PeakName, Elevation
FROM Peaks AS p 
JOIN Mountains AS m ON p.MountainId = m.Id
WHERE MountainRange = 'Rila'
ORDER BY Elevation DESC