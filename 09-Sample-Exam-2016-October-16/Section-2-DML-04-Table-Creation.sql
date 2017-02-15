CREATE TABLE CustomerReviews(
  ReviewID int, 
  ReviewContent varchar(255) NOT NULL,
  ReviewGrade int CHECK(ReviewGrade BETWEEN 0 AND 10), 
  AirlineID int NOT NULL,
  CustomerID int NOT NULL,
  CONSTRAINT PK_CustomerReviews PRIMARY KEY (ReviewID),
  CONSTRAINT FK_CustomerReviews_Airlines FOREIGN KEY (AirlineID) REFERENCES Airlines(AirlineID),
  CONSTRAINT FK_CustomerReviews_Customers FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
)

CREATE TABLE CustomerBankAccounts(
  AccountID int,
  AccountNumber varchar(10) NOT NULL UNIQUE,
  Balance numeric(10, 2) NOT NULL,
  CustomerID int NOT NULL,
  CONSTRAINT PK_CustomerBankAccounts PRIMARY KEY (AccountID),
  CONSTRAINT FK_CustomerBankAccounts_Customers FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
)