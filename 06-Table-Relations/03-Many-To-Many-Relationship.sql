CREATE TABLE Students(
  StudentID int NOT NULL,
  Name nvarchar(50) NOT NULL,
  CONSTRAINT PK_Students PRIMARY KEY (StudentID)
)

CREATE TABLE Exams(
  ExamID int NOT NULL,
  Name nvarchar(50) NOT NULL,
  CONSTRAINT PK_Exams PRIMARY KEY (ExamID)
)

CREATE TABLE StudentsExams(
  StudentID int NOT NULL,
  ExamID int NOT NULL,
  CONSTRAINT PK_StudentsExams PRIMARY KEY (StudentID, ExamID),
  CONSTRAINT FK_StudentsExams_Students FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
  CONSTRAINT FK_StudentsExams_Exams FOREIGN KEY (ExamID) REFERENCES Exams(ExamID)
)

INSERT INTO Students VALUES
  (1, 'Mila'), 
  (2, 'Toni'), 
  (3, 'Ron')

INSERT INTO Exams VALUES
  (101, 'SpringMVC'), 
  (102, 'Neo4j'), 
  (103, 'Oracle 11g')

INSERT INTO StudentsExams VALUES
  (1, 101), 
  (1, 102), 
  (2, 101), 
  (3, 103), 
  (2, 102), 
  (2, 103)