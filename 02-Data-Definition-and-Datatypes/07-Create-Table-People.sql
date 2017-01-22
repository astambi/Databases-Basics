CREATE TABLE People (
	Id int UNIQUE IDENTITY,
	Name nvarchar(200) NOT NULL,
	Picture varbinary(MAX),
	Height numeric(3, 2), -- Judge also accepts float(2)
	Weight numeric(5, 2), -- Judge also accepts float(2)
	Gender char(1) NOT NULL,
	Birthdate date NOT NULL,
	Biography nvarchar(MAX),
	CONSTRAINT PK_People PRIMARY KEY(Id),
	CONSTRAINT CK_People_Gender CHECK (Gender='m' OR Gender='f')
)

INSERT INTO People (Name, Picture, Height, Weight, Gender, Birthdate, Biography)
VALUES
	('Maria', 011010101, 1.64, 65.77, 'f', '1985/01/17', 'Marias Bio'),
	('Peter', 01111101, 1.88, 87.00, 'm', '1980/06/11', 'Peters Bio'),
	('Ida', 100000001, 1.64, 65.77, 'f', '1985/05/03', 'Idas Bio'),
	('Nia', 000011010, 1.70, 60.52, 'f', '1975/06/06', 'Nias Bio'),
	('Tom', 101010101, 1.90, 85.7, 'm', '1995/08/08', 'Toms Bio')