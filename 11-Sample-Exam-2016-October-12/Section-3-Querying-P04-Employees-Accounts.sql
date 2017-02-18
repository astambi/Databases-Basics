SELECT TOP (5)
  e.EmployeeID, e.FirstName, a.AccountNumber
FROM Employees AS e
LEFT JOIN EmployeesAccounts AS ea ON ea.EmployeeID = e.EmployeeID
JOIN Accounts as a on ea.AccountID = a.AccountID
WHERE YEAR(a.StartDate) > 2012
ORDER BY e.FirstName DESC