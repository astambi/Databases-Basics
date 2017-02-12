PROCEDURE / PROC
EXECUTE / EXEC

-- CREATE PROCEDURE
CREATE PROC usp_SelectEmployeesBySeniority
AS
  SELECT * 
  FROM Employees
  WHERE	DATEDIFF(YEAR, HireDate, GETDATE()) > 5
GO

-- ALTER PROCEDURE
ALTER PROC dbo.usp_SelectEmployeesBySeniority
AS
  SELECT FirstName, LastName, HireDate
  FROM Employees
  WHERE	DATEDIFF(YEAR, HireDate, GETDATE()) > 5
  ORDER BY HireDate
GO

-- EXECUTE PROCEDURE
EXEC dbo.usp_SelectEmployeesBySeniority;

INSERT INTO Customers
EXEC dbo.usp_SelectEmployeesBySeniority

EXEC sp_depends 'usp_SelectEmployeesBySeniority';

-- DROP PROCEDURE
DROP PROC dbo.usp_SelectEmployeesBySeniority

-- PROCEDURE with parameters
CREATE PROC usp_SelectEmployeesBySeniority (@minYearsAtWork int = 5)
AS
  SELECT FirstName, LastName, HireDate, 
    DATEDIFF(YEAR, HireDate, GETDATE()) AS Years
  FROM Employees
  WHERE DATEDIFF(YEAR, HireDate, GETDATE()) > @minYearsAtWork
  ORDER BY HireDate DESC
GO

EXEC dbo.usp_SelectEmployeesBySeniority;
EXEC dbo.usp_SelectEmployeesBySeniority 17;
EXEC dbo.usp_SelectEmployeesBySeniority @minYearsAtWork = 17;

-- Passing parameters 
-- by parameter name
EXEC usp_AddCustomer 
  @customerID = 'ALFKI',
  @companyName = 'Alfreds Futterkiste',
  @address = 'Obere Str. 57',
  @city = 'Berlin',
  @phone = '030-0074321' 
-- by position
EXEC usp_AddCustomer 'ALFKI2', 'Alfreds Futterkiste', 'Obere Str. 57', 'Berlin', '030-0074321';

-- PROCEDURE with OUTPUT
CREATE PROCEDURE dbo.usp_AddNumbers
   @firstNumber smallint,
   @secondNumber smallint,
   @result int OUTPUT
AS
   SET @result = @firstNumber + @secondNumber
GO

DECLARE @answer smallint;
EXECUTE usp_AddNumbers 5, 6, @answer OUTPUT;
SELECT 'The result is: ', @answer -- The result is: 11