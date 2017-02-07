CREATE DATABASE ConferenceRooms
GO

USE ConferenceRooms
GO

CREATE TABLE Employees(
  Id int IDENTITY,
  EmployeeName nvarchar(50) NOT NULL,
  CONSTRAINT PK_Employees PRIMARY KEY (Id)
)

CREATE TABLE Rooms(
  Id int IDENTITY,
  Location nvarchar(50) NOT NULL,
  CONSTRAINT PK_Rooms PRIMARY KEY (Id)
)

CREATE TABLE Meetings(
  Id int IDENTITY,
  StartTime datetime NOT NULL,
  EndTime datetime,
  CONSTRAINT PK_Meetings PRIMARY KEY (Id)
)

CREATE TABLE Topics(
  Id int IDENTITY,
  Description nvarchar(50) NOT NULL,
  CONSTRAINT PK_Topics PRIMARY KEY (Id)
)

CREATE TABLE MeetingsEmployees(
  MeetingId int, 
  EmployeesId int,
  CONSTRAINT PK_MeetingsEmployees PRIMARY KEY (MeetingId, EmployeesId),
  CONSTRAINT PK_MeetingsEmployees_Meetings FOREIGN KEY (MeetingId) REFERENCES Meetings(Id), -- many-to-many
  CONSTRAINT PK_MeetingsEmployees_Employees FOREIGN KEY (EmployeesId) REFERENCES Employees(Id) -- many-to-many
)

CREATE TABLE MeetingsTopics(
  MeetingId int, 
  TopicId int,
  CONSTRAINT PK_MeetingsTopics PRIMARY KEY (MeetingId, TopicId),
  CONSTRAINT PK_MeetingsTopics_Meetings FOREIGN KEY (MeetingId) REFERENCES Meetings(Id), -- many-to-many
  CONSTRAINT PK_MeetingsTopics_Topics FOREIGN KEY (TopicId) REFERENCES Topics(Id) -- many-to-many
)

CREATE TABLE MeetingsRooms(
  MeetingId int UNIQUE, -- 1-to-1
  RoomId int,
  CONSTRAINT PK_MeetingsRooms PRIMARY KEY (MeetingId, RoomId),
  CONSTRAINT PK_MeetingsRooms_Meetings FOREIGN KEY (MeetingId) REFERENCES Meetings(Id), -- 1-to-1
  CONSTRAINT PK_MeetingsRooms_Rooms FOREIGN KEY (RoomId) REFERENCES Rooms(Id) -- 1-to-1
)