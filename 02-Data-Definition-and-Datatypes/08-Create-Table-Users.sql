CREATE TABLE Users (
	Id int UNIQUE IDENTITY,
	Username varchar(30) UNIQUE NOT NULL,
	Password varchar(26) NOT NULL,
	ProfilePicture varbinary(900),
	LastLoginTime datetime,
	IsDeleted bit DEFAULT 0,
	CONSTRAINT PK_Users PRIMARY KEY(Id)
)

INSERT INTO Users(Username, Password, ProfilePicture, LastLoginTime, IsDeleted)
VALUES
	('tom', 'asdasdasdasd', 01010, '2016/01/18 00:01:50', 0),
	('maria', 'password', 0000, '2016/01/17 16:50:50', 0),
	('nia', 'asdasdasdasd', 1111, '2016/01/17 08:45:45', 1),
	('peter', 'password', 111, '2016/01/17 15:01:50', 0),
	('eva', 'password', 011110, '2016/01/17 22:23:50', 1)