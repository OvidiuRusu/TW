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
  Matricol VARCHAR(20),
  Semestru INT(1), 
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
  Semestru INT(1),
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

INSERT INTO universitate VALUES(1,'Univ. Al. I. Cuza');

INSERT INTO facultate VALUES(101,'Facultatea de Informatica', 1);

INSERT INTO account VALUES (1, 'sabin.buraga', 'sunt_sefu', 'P');
INSERT INTO account VALUES (2, 'ciprian.amariei', 'parola', 'P');
INSERT INTO account VALUES (3, 'cristian.farsianru', 'parola', 'P');
INSERT INTO account VALUES (4, 'alex.moruz', 'parola', 'P');
INSERT INTO account VALUES (5, 'adrian.iftene', 'parola', 'P');
INSERT INTO account VALUES (6, 'florin.iacob', 'parola', 'P');
INSERT INTO account VALUES (7, 'raluca.gimbuta', 'parola', 'P');
INSERT INTO account VALUES (8, 'lucian.lazar', 'parola', 'P');
INSERT INTO account VALUES (9, 'stefan.luchian', 'parola', 'P');
INSERT INTO account VALUES (10, 'lenuta.alboaie', 'parola', 'P');
INSERT INTO account VALUES (11, 'emilian.mitocariu', 'ps', 'S');
INSERT INTO account VALUES (12, 'vlad.tacutanu', 'ps', 'S');
INSERT INTO account VALUES (13, 'ovidiu.rusu', 'ps', 'S');
INSERT INTO account VALUES (14, 'sorin.stoian', 'ps', 'S');

INSERT INTO profesor VALUES (1, 'Buraga', 'Sabin', 'sabin.buraga@info.uaic.ro', 'Conf.dr.', 101, 1);
INSERT INTO profesor VALUES (2, 'Amariei', 'Ciprian', 'ciprian.amariei@info.uaic.ro', 'Prof', 101, 2);
INSERT INTO profesor VALUES (3, 'Farsinaru', 'Cristian', 'cristian.farsianru@info.uaic.ro', 'Lect.dr.', 101, 3);
INSERT INTO profesor VALUES (4, 'Moruz', 'Alex', 'alex.moruz@info.uaic.ro', 'Lect.dr.', 101, 4);
INSERT INTO profesor VALUES (5, 'Iftene', 'Adrian', 'adrian.iftene@info.uaic.ro', 'Decan', 101, 5);
INSERT INTO profesor VALUES (6, 'Iacob', 'Florin', 'florin.iacob@info.uaic.ro', 'Lect.dr.', 101, 6);
INSERT INTO profesor VALUES (7, 'Gimbuta', 'Raluca', 'raluca.gimbuta@info.uaic.ro', 'Assist.', 101, 7);
INSERT INTO profesor VALUES (8, 'Lazar', 'Lucian', 'lucian.lazar@info.uaic.ro', 'Assist.', 101, 8);
INSERT INTO profesor VALUES (9, 'Luchian', 'Stefan', 'stefan.luchian@info.uaic.ro', 'Assist.', 101, 9);
INSERT INTO profesor VALUES (10, 'Lenuta', 'Alboaie', 'lenuta.alboaie@info.uaic.ro', 'Assist.', 101, 10);
  
  
INSERT INTO materie VALUES(1,'Algoritmi Genetici',3,NULL);
INSERT INTO materie VALUES(2,'Limbaje formale, automate si compilatoare',3,NULL);
INSERT INTO materie VALUES(3,'Retele',3,NULL);
INSERT INTO materie VALUES(4,'Baze de date',3,NULL);
INSERT INTO materie VALUES(5,'Algoritmica Grafurilor',3,NULL);
INSERT INTO materie VALUES(6,'Limba Engleza III',3,NULL);
INSERT INTO materie VALUES(7,'SGBD',4,NULL);
INSERT INTO materie VALUES(8,'Tehnologii Web',4,NULL);
INSERT INTO materie VALUES(9,'Programare Logica',4,NULL);
INSERT INTO materie VALUES(10,'Ingineria Programarii',4,NULL);
INSERT INTO materie VALUES(11,'Programare Avansata',4,NULL);


INSERT INTO student VALUES(1,'Mitocariu','Emilian','emilian.mitocariu@info.uaic.ro',NULL,4,101,11);
INSERT INTO student VALUES(2,'Tacutanu','Vlad','vlad.tacutanu@info.uaic.ro',NULL,4,101,12);
INSERT INTO student VALUES(3,'Rusu','Ovidiu','ovidiu.rusu@info.uaic.ro',NULL,4,101,13);
INSERT INTO student VALUES(4,'Stoian','Sorin','sorin.stoian@info.uaic.ro',NULL,4,101,14);

INSERT INTO student_materie VALUES(1,1,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(1,2,,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(1,3,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(1,4,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(1,5,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(1,6,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(1,7,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(1,8,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(1,9,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(1,10,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(1,11,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(2,1,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(2,2,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(2,3,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(2,4,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(2,5,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(2,6,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(2,7,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(2,8,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(2,9,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(2,10,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(2,11,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(3,1,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(3,2,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(3,3,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(3,4,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(3,5,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(3,6,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(3,7,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(3,8,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(3,9,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(3,10,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(3,11,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(4,1,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(4,2,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(4,3,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(4,4,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(4,5,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(4,6,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(4,7,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(4,8,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(4,9,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(4,10,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(4,11,'2015-02-14','In Curs');

INSERT INTO profesor_materie VALUES(9,1);
INSERT INTO profesor_materie VALUES(4,2);
INSERT INTO profesor_materie VALUES(10,3);
INSERT INTO profesor_materie VALUES(7,4);
INSERT INTO profesor_materie VALUES(6,5);
INSERT INTO profesor_materie VALUES(3,6);
INSERT INTO profesor_materie VALUES(8,7);
INSERT INTO profesor_materie VALUES(1,8);
INSERT INTO profesor_materie VALUES(2,9);
INSERT INTO profesor_materie VALUES(5,10);
INSERT INTO profesor_materie VALUES(3,11);


