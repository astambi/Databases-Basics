CREATE DATABASE Football
GO

USE Football
GO

CREATE TABLE Teams(
  Id int IDENTITY,
  Name varchar(50) NOT NULL,
  CONSTRAINT PK_Teams PRIMARY KEY(Id)
)

CREATE TABLE Leagues(
  Id int IDENTITY,
  Name varchar(50) NOT NULL,
  CONSTRAINT PK_Leagues PRIMARY KEY(Id)
)

CREATE TABLE TeamsLeagues(
  TeamId int NOT NULL, 
  LeagueId int NOT NULL,
  CONSTRAINT PK_TeamsLeagues PRIMARY KEY(TeamId, LeagueId),
  CONSTRAINT FK_TeamsLeagues_Teams FOREIGN KEY (TeamId) REFERENCES Teams(Id), -- many-to-many
  CONSTRAINT FK_TeamsLeagues_Leagues FOREIGN KEY (LeagueId) REFERENCES Leagues(Id) -- many-to-many
)

CREATE TABLE Players(
  Id int IDENTITY,
  FirstName varchar(50) NOT NULL,
  LastName varchar(50) NOT NULL,
  Salary money DEFAULT 0,
  TeamId int,  
  CONSTRAINT PK_Players PRIMARY KEY(Id),
  CONSTRAINT FK_Players_Teams FOREIGN KEY (TeamId) REFERENCES Teams(Id) -- 1-to-many
)

CREATE TABLE Managers(
  Id int IDENTITY,
  FirstName varchar(50) NOT NULL,
  LastName varchar(50) NOT NULL,
  Salary money DEFAULT 0,
  CONSTRAINT PK_Managers PRIMARY KEY(Id)
)

CREATE TABLE TeamsManagers(
  TeamId int NOT NULL UNIQUE, -- 1-to-1
  ManagerId int NOT NULL UNIQUE, -- 1-to-1
  CONSTRAINT PK_TeamsManagers PRIMARY KEY (TeamId, ManagerId),
  CONSTRAINT FK_TeamsManagers_Teams FOREIGN KEY (TeamId) REFERENCES Teams(Id), -- 1-to-1
  CONSTRAINT FK_TeamsManagers_Managerss FOREIGN KEY (ManagerId) REFERENCES Managers(Id) -- 1-to-1
)