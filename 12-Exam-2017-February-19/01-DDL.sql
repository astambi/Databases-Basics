--CREATE DATABASE Bakery
--GO
--USE Bakery
--GO

CREATE TABLE Countries(
  Id int IDENTITY,
  Name nvarchar(50) UNIQUE,
  CONSTRAINT PK_Countries PRIMARY KEY (Id)
)

CREATE TABLE Products(
  Id int IDENTITY,
  Name nvarchar(25) UNIQUE,
  Description nvarchar(250),
  Recipe nvarchar(max), 
  Price money CHECK(Price > 0),
  CONSTRAINT PK_Products PRIMARY KEY (Id)
)

CREATE TABLE Customers(
  Id int IDENTITY,
  FirstName nvarchar(25),
  LastName nvarchar(25),
  Gender char(1) CHECK (Gender IN ('M', 'F')),
  Age int, 
  PhoneNumber char(10) CHECK(ISNUMERIC(PhoneNumber) = 1), -- digits only
  CountryId int,
  CONSTRAINT PK_Customers PRIMARY KEY (Id),
  CONSTRAINT FK_Customers_Countries FOREIGN KEY (CountryId) REFERENCES Countries(Id)  
)

CREATE TABLE Feedbacks(
  Id int IDENTITY, 
  Description nvarchar(255),
  Rate decimal(4, 2) CHECK(Rate BETWEEN 0 AND 10),
  ProductId int, 
  CustomerId int,
  CONSTRAINT PK_Feedbacks PRIMARY KEY (Id),
  CONSTRAINT FK_Feedbacks_Products FOREIGN KEY (ProductId) REFERENCES Products(Id),  
  CONSTRAINT FK_Feedbacks_Customers FOREIGN KEY (CustomerId) REFERENCES Customers(Id)
)

CREATE TABLE Distributors(
  Id int IDENTITY,
  Name nvarchar(25) UNIQUE, 
  AddressText nvarchar(30),
  Summary nvarchar(200),
  CountryId int,
  CONSTRAINT PK_Distributors PRIMARY KEY (Id),
  CONSTRAINT FK_Distributors_Countries FOREIGN KEY (CountryId) REFERENCES Countries(Id)
)

CREATE TABLE Ingredients(
  Id int IDENTITY,
  Name nvarchar(30),
  Description nvarchar(200),
  OriginCountryId int, 
  DistributorId int,
  CONSTRAINT PK_Ingredients PRIMARY KEY (Id),
  CONSTRAINT FK_Ingredients_Countries FOREIGN KEY (OriginCountryId) REFERENCES Countries(Id),  
  CONSTRAINT FK_Ingredients_Distributors FOREIGN KEY (DistributorId) REFERENCES Distributors(Id)
)

CREATE TABLE ProductsIngredients(
  ProductId int, 
  IngredientId int,
  CONSTRAINT PK_ProductsIngredients PRIMARY KEY (ProductId, IngredientId),
  CONSTRAINT FK_ProductsIngredients_Products FOREIGN KEY (ProductId) REFERENCES Products(Id),  
  CONSTRAINT FK_ProductsIngredients_Ingredients FOREIGN KEY (IngredientId) REFERENCES Ingredients(Id)
)