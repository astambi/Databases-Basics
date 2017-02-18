SELECT 
  SUM(l.Amount) AS TotalLoanAmount,
  MAX(l.Interest) AS MaxInterest,
  MIN(e.Salary) AS MinEmployeeSalary
FROM Loans AS l
JOIN EmployeesLoans AS el ON l.LoanID = el.LoanID
JOIN Employees AS e ON e.EmployeeID = el.EmployeeID