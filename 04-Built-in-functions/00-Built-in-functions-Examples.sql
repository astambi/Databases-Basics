-- USE SoftUni
-- if any NULL coll => the result is NULL
SELECT FirstName + ' ' + MiddleName + ' ' + LastName AS [Full Name]
FROM Employees

-- a NULL col is concatenated as an empty string ''
SELECT CONCAT(FirstName, ' ', MiddleName, ' ', LastName) AS [Full Name]
FROM Employees

-- a NULL col is concatenated as an empty string ''
SELECT FirstName + ' ' + ISNULL(MiddleName, '') + ' ' + LastName AS [Full Name]
FROM Employees

--USE Demo
SELECT 
  CustomerID, FirstName, LastName, 
  LEFT(PaymentNumber, 6) + REPLICATE('*', LEN(PaymentNumber) - 6) AS [Payment Number]
FROM Customers

CREATE VIEW V_PublicPaymentInfo AS
SELECT 
  CustomerID, FirstName, LastName, 
  LEFT(PaymentNumber, 6) + REPLICATE('*', LEN(PaymentNumber) - 6) AS [Payment Number]
FROM Customers
GO
SELECT * FROM V_PublicPaymentInfo

SELECT 
  Id, 
  SQRT(SQUARE(X1 - X2) + SQUARE(Y1 - Y2)) AS [Line Length]
FROM Lines

SELECT
  FLOOR(PI()) AS FLOOR, 
  PI() AS PI,
  CEILING (PI()) AS CEILING
FROM Lines

SELECT 
  Id, Name,  Quantity, BoxCapacity, PalletCapacity,
  CEILING(
    CEILING(CAST(Quantity AS float) / BoxCapacity) / PalletCapacity) 
    AS [Number of pallets]
FROM Products

CREATE TABLE Invoices (
  InvoiceId int NOT NULL IDENTITY,
  InvoiceDate datetime NOT NULL DEFAULT GETDATE(),
  Total money NOT NULL
)

INSERT INTO Invoices (InvoiceDate, Total)
VALUES (DEFAULT, 1.98), (DEFAULT, 3.98), (DEFAULT, 5.94), (DEFAULT, 8.91)

SELECT 
  Total, 
  YEAR(InvoiceDate) AS Year, 
  DATEPART(QUARTER, invoicedate) as Quarter,
  MONTH(InvoiceDate) AS Month, 
  DAY(InvoiceDate) AS Day
FROM Invoices

CREATE VIEW V_QuaterlyReport AS
SELECT 
  Total, 
  YEAR(InvoiceDate) AS Year, 
  DATEPART(QUARTER, invoicedate) as Quarter,
  MONTH(InvoiceDate) AS Month, 
  DAY(InvoiceDate) AS Day
FROM Invoices
GO
SELECT * FROM V_QuaterlyReport

-- USE SoftUni
SELECT
  EmployeeID, FirstName, LastName, HireDate,
  DATEDIFF(YEAR, HireDate, GETDATE()) AS [Years in Service]
FROM Employees

SELECT DATENAME(WEEKDAY, GETDATE()) AS Weekday

SELECT
  ProjectID, Name,
  ISNULL(CAST(EndDate AS varchar), 'Not finished') AS [Date Completed]
FROM Projects

SELECT EmployeeID, FirstName, LastName
FROM Employees
ORDER BY EmployeeID
  OFFSET 10 ROWS
  FETCH NEXT 5 ROWS ONLY
  
SELECT EmployeeID, FirstName, LastName
FROM Employees
WHERE FirstName LIKE 'Ro%'

SELECT CustomerID, FirstName, LastName
FROM Customers
WHERE FirstName LIKE '%max!%' ESCAPE '!'

