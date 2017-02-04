CREATE TABLE Majors(
  MajorID int NOT NULL,
  Name nvarchar(50) NOT NULL,
  CONSTRAINT PK_Majors PRIMARY KEY (MajorID)
)

CREATE TABLE Students(
  StudentID int NOT NULL,
  StudentNumber int NOT NULL UNIQUE,
  StudentName nvarchar(200) NOT NULL,
  MajorID int,
  CONSTRAINT PK_Students PRIMARY KEY (StudentID),
  CONSTRAINT FK_Students_Majors FOREIGN KEY (MajorID) REFERENCES Majors(MajorID)
)

CREATE TABLE Payments(
  PaymentID int NOT NULL,
  PaymentDate date NOT NULL,
  PaymentAmount money NOT NULL,
  StudentID int NOT NULL,
  CONSTRAINT PK_Payments PRIMARY KEY (PaymentID),
  CONSTRAINT FK_Payments_Students FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
)

CREATE TABLE Subjects(
  SubjectID int NOT NULL,
  SubjectName nvarchar(50) NOT NULL,
  CONSTRAINT PK_Subjects PRIMARY KEY (SubjectID)
)

CREATE TABLE Agenda(
  StudentID int NOT NULL,
  SubjectID int NOT NULL,
  CONSTRAINT PK_Agenda PRIMARY KEY (StudentID, SubjectID),
  CONSTRAINT FK_Agenda_Students FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
  CONSTRAINT FK_Agenda_Subjects FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID)
)