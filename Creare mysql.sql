DROP TABLE Nota;
DROP TABLE Submission;
DROP TABLE Assignment;
DROP TABLE Student_Materie;
DROP TABLE Profesor_Materie;
DROP TABLE Materie;
DROP TABLE Profesor;
DROP TABLE Student;
DROP TABLE Account;
DROP TABLE Facultate;
DROP TABLE Universitate;

CREATE TABLE Account(
  IdAccount INT(10) PRIMARY KEY,
  Username VARCHAR(25) UNIQUE,
  Password VARCHAR(25) NOT NULL,
  Tip VARCHAR(1) NOT NULL,
  CHECK (Tip IN ('S','P','A'))
  );

CREATE TABLE Universitate(
  IdUniversitate INT(10) PRIMARY KEY,
  NumeUniv VARCHAR(100) NOT NULL
  );

CREATE TABLE Facultate(
  IdFacultate INT(10) PRIMARY KEY,
  NumeFac VARCHAR(100) NOT NULL,
  IdUniversitate INT(10),
  FOREIGN KEY(IdUniversitate) REFERENCES Universitate(IdUniversitate)  
  ) ENGINE=INNODB;
CREATE TABLE Student(
  IdStudent INT(10) PRIMARY KEY,
  Nume VARCHAR(30) NOT NULL,
  Prenume VARCHAR(30) NOT NULL,
  Email VARCHAR(50),
  IdFacultate INT(10),
  IdAccount INT(10),
  CHECK (Email LIKE '%@%.%'),
  FOREIGN KEY(IdFacultate) REFERENCES Facultate(IdFacultate),
  FOREIGN KEY(IdAccount) REFERENCES Account(IdAccount)
  ) ENGINE=INNODB;

CREATE TABLE Profesor(
  IdProfesor INT(10) PRIMARY KEY,
  Nume VARCHAR(30) NOT NULL,
  Prenume VARCHAR(30) NOT NULL,
  Email VARCHAR(50),
  Titlu VARCHAR(15),
  IdFacultate INT(10),
  IdAccount INT(10),
  CHECK (Email LIKE '%@%.%'),
  FOREIGN KEY(IdFacultate) REFERENCES Facultate(IdFacultate),
  FOREIGN KEY(IdAccount) REFERENCES Account(IdAccount)
  ) ENGINE=INNODB;
  
CREATE TABLE Materie(
  IdMaterie INT(10) PRIMARY KEY,
  Nume VARCHAR(50) NOT NULL,
  Descriere VARCHAR(255)
  );
  
CREATE TABLE Student_Materie(
  IdStudent INT(10) NOT NULL,
  IdMaterie INT(10) NOT NULL,
  StartDate DATE,
  Status VARCHAR(10),
  FOREIGN KEY(IdStudent) REFERENCES Student(IdStudent),
  FOREIGN KEY(IdMaterie) REFERENCES Materie(IdMaterie),
  CHECK (Status IN ('Promovat','Nepromovat','In Curs'))
  ) ENGINE=INNODB;

CREATE TABLE Profesor_Materie(
  IdProfesor INT(10) NOT NULL,
  IdMaterie INT(10) NOT NULL,
  FOREIGN KEY(IdProfesor) REFERENCES Profesor(IdProfesor),
  FOREIGN KEY(IdMaterie) REFERENCES Materie(IdMaterie)
  ) ENGINE=INNODB;
  
CREATE TABLE Assignment(
  IdAssignment INT(10) PRIMARY KEY,
  IdMaterie INT(10) NOT NULL,
  Titlu VARCHAR(30) NOT NULL,
  Descriere VARCHAR(255),
  AssignDate DATE NOT NULL,
  DueDate DATE NOT NULL,
  Punctaj DECIMAL(3) NOT NULL,
  Path VARCHAR(255),
  FOREIGN KEY(IdMaterie) REFERENCES Materie(IdMaterie)
  ) ENGINE=INNODB;
  
CREATE TABLE Submission(
  IdSubmission INT(10) PRIMARY KEY,
  IdStudent INT(10) NOT NULL,
  IdAssignment INT(10) NOT NULL,
  Path VARCHAR(255),
  FOREIGN KEY(IdStudent) REFERENCES Student(IdStudent),
  FOREIGN KEY(IdAssignment) REFERENCES Assignment(IdAssignment)
  ) ENGINE=INNODB;

CREATE TABLE Nota(
  IdNota INT(10) PRIMARY KEY,
  IdSubmission INT(10) NOT NULL,
  IdProfesor INT(10) NOT NULL,
  Nota INT(3) NOT NULL,
  FOREIGN KEY(IdProfesor) REFERENCES Profesor(IdProfesor),
  FOREIGN KEY(IdSubmission) REFERENCES Submission(IdSubmission)
  ) ENGINE=INNODB;