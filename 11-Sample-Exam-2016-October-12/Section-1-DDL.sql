CREATE TABLE DepositTypes(
  DepositTypeID int,
  Name varchar(20),
  CONSTRAINT PK_DepositTypes PRIMARY KEY (DepositTypeID)
)

CREATE TABLE Deposits(
  DepositID int IDENTITY,
  Amount decimal(10, 2),
  StartDate date, 
  EndDate date,
  DepositTypeID int NOT NULL,
  CustomerID int NOT NULL,
  CONSTRAINT PK_Deposits PRIMARY KEY (DepositID),
  CONSTRAINT FK_Deposits_DepositType FOREIGN KEY (DepositTypeID) REFERENCES DepositTypes(DepositTypeID),
  CONSTRAINT FK_Deposits_Customers FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
)

CREATE TABLE EmployeesDeposits(
  EmployeeID int NOT NULL, 
  DepositID int NOT NULL,
  CONSTRAINT PK_EmployeesDeposits PRIMARY KEY (EmployeeID, DepositID),
  CONSTRAINT FK_EmployeesDeposits_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
  CONSTRAINT FK_EmployeesDeposits_Deposits FOREIGN KEY (DepositID) REFERENCES Deposits(DepositID)
)

CREATE TABLE CreditHistory(
  CreditHistoryID int, 
  Mark char(1),
  StartDate date,
  EndDate date,
  CustomerID int NOT NULL,
  CONSTRAINT PK_CreditHistory PRIMARY KEY (CreditHistoryID),
  CONSTRAINT FK_CreditHistory_Customers FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
)

CREATE TABLE Payments(
  PayementID int,
  Date date,
  Amount decimal(10, 2),
  LoanID int NOT NULL,
  CONSTRAINT PK_Payments PRIMARY KEY (PayementID),
  CONSTRAINT FK_Payments_Customers FOREIGN KEY (LoanID) REFERENCES Loans(LoanID)
)

CREATE TABLE Users(
  UserID int,
  UserName varchar(20), 
  Password varchar(20),
  CustomerID int NOT NULL UNIQUE,
  CONSTRAINT PK_Users PRIMARY KEY (UserID),
  CONSTRAINT FK_Users_Customers FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
)

ALTER TABLE Employees
ADD ManagerID int
CONSTRAINT FK_Employees_Employees FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID)