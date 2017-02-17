--CREATE DATABASE TheNerdHerd
--GO
--USE TheNerdHerd
--GO

CREATE TABLE Locations(
  Id int IDENTITY,
  Latitude float, 
  Longitude float,
  CONSTRAINT PK_Locations PRIMARY KEY (Id)
)

CREATE TABLE Credentials(
  Id int IDENTITY,
  Email varchar(30), 
  Password varchar(20),
  CONSTRAINT PK_Credentials PRIMARY KEY (Id)
)

CREATE TABLE Users(
  Id int IDENTITY,
  Nickname varchar(25),
  Gender char(1), 
  Age int, 
  LocationId int,
  CredentialId int NOT NULL UNIQUE,
  CONSTRAINT PK_Users PRIMARY KEY (Id),
  CONSTRAINT FK_Users_Locations FOREIGN KEY (LocationId) REFERENCES Locations(Id),
  CONSTRAINT FK_Users_Credentials FOREIGN KEY (CredentialId) REFERENCES Credentials(Id)
)

CREATE TABLE Chats(
  Id int IDENTITY,
  Title varchar(32),
  StartDate date, 
  IsActive bit,
  CONSTRAINT PK_Chats PRIMARY KEY (Id)
)

CREATE TABLE Messages(
  Id int IDENTITY,
  Content varchar(200),
  SentOn date,
  ChatId int NOT NULL,
  UserId int NOT NULL,
  CONSTRAINT PK_Messages PRIMARY KEY (Id),
  CONSTRAINT FK_Messages_Chats FOREIGN KEY (ChatId) REFERENCES Chats(Id),
  CONSTRAINT FK_Messages_Users FOREIGN KEY (UserId) REFERENCES Users(Id)
)

CREATE TABLE UsersChats(
  UserId int NOT NULL,
  ChatId int NOT NULL,
  CONSTRAINT PK_UsersChats PRIMARY KEY (ChatId, UserId), 
  -- NB! Judge wont accept PRIMARY KEY (UserId, ChatId) insufficient info on that in problem
  -- NB! PRIMARY KEY (ChatId, UserId) <> PRIMARY KEY (UserId, ChatId) !
  CONSTRAINT FK_UsersChats_Users FOREIGN KEY (UserId) REFERENCES Users(Id),
  CONSTRAINT FK_UsersChats_Chats FOREIGN KEY (ChatId) REFERENCES Chats(Id)
)