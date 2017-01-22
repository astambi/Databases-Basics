CREATE TABLE Minions (
	Id int NOT NULL, 
	Name nvarchar(50), 
	Age int,
	CONSTRAINT PK_Minions PRIMARY KEY (Id)
)

CREATE TABLE Towns (
	Id int NOT NULL, 
	Name nvarchar(50), 
	CONSTRAINT PK_Towns PRIMARY KEY (Id)
)