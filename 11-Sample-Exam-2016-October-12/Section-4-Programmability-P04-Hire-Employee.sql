CREATE TRIGGER tr_HireEmployee ON Employees 
FOR INSERT
AS
BEGIN
  UPDATE EmployeesLoans
  SET EmployeeID = (SELECT EmployeeID FROM inserted)
  WHERE EmployeeID = (SELECT MAX(EmployeeID) FROM Employees 
                      WHERE EmployeeID < (SELECT EmployeeID FROM inserted))  
END

--testing
SELECT TOP (1) * FROM Employees AS e
JOIN EmployeesLoans AS el ON el.EmployeeID = e.EmployeeID
ORDER BY e.EmployeeID DESC

INSERT INTO Employees VALUES (31, 'Jake', '2016/12/12', 500, 2, NULL);

SELECT TOP (1) * FROM Employees AS e
JOIN EmployeesLoans AS el ON el.EmployeeID = e.EmployeeID
ORDER BY e.EmployeeID DESC