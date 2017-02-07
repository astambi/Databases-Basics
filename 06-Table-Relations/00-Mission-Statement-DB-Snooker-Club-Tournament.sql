CREATE DATABASE SnookerTournament
GO

USE SnookerTournament
GO

CREATE TABLE Members(
  Id int IDENTITY,
  Name nvarchar(50) NOT NULL,
  CONSTRAINT PK_Members PRIMARY KEY(Id)
)

CREATE TABLE Tournaments(
  Id int IDENTITY,
  Description nvarchar(50) NOT NULL,
  StartDate date, 
  EndDate date,
  CONSTRAINT PK_Tournaments PRIMARY KEY(Id),
)

CREATE TABLE Matches(
  Id int IDENTITY,
  TournamentId int NOT NULL, 
  StartTime datetime NOT NULL, 
  EndTime datetime,
  CONSTRAINT PK_Matches PRIMARY KEY(Id),
  CONSTRAINT FK_Matches_Tournaments FOREIGN KEY (TournamentId) REFERENCES Tournaments(Id), -- many-to-1
  CONSTRAINT CH_Matches_Duration CHECK (DATEDIFF(minute,StartTime,EndTime) = 90)
)

CREATE TABLE PlayersMatches(
  PlayerId int,  
  MatchId int, 
  FramesWon int DEFAULT 0,
  HighestBreak int DEFAULT 0,
  CONSTRAINT PK_PlayersMatches PRIMARY KEY (PlayerId, MatchId), 
  CONSTRAINT FK_PlayersMatches_Matches FOREIGN KEY (MatchId) REFERENCES Matches(Id), -- many-to-many
  CONSTRAINT FK_PlayersMatches_Players FOREIGN KEY (PlayerId) REFERENCES Members(Id) -- many-to-many
) 