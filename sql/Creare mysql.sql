DROP TABLE Resource;
DROP TABLE Nota;
DROP TABLE Submission;
DROP TABLE Assignment;
DROP TABLE Student_Materie;
DROP TABLE Profesor_Materie;
DROP TABLE Profesor;
DROP TABLE Student;
DROP TABLE Materie;
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
  Data DATE NOT NULL,
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

CREATE TABLE Resource(
  IdResursa INT(10) PRIMARY KEY,
  Nume VARCHAR(50) NOT NULL,
  IdMaterie INT(10) NOT NULL,
  Path VARCHAR(255),
  FOREIGN KEY(IdMaterie) REFERENCES Materie(IdMaterie)
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
INSERT INTO account VALUES (15, 'marian.budai', 'ps', 'S');
INSERT INTO account VALUES (16, 'mihai.cosbuc', 'parola', 'P');
INSERT INTO account VALUES (17, 'george.radulescu', 'parola', 'P');
INSERT INTO account VALUES (18, 'cristian.vidrascu', 'parola', 'P');
INSERT INTO account VALUES (19, 'florentin.olariu', 'parola', 'P');
INSERT INTO account VALUES (20, 'dorel.lucanu', 'parola', 'P');

INSERT INTO profesor VALUES (1, 'Buraga', 'Sabin', 'sabin.buraga@info.uaic.ro', 'Conf.dr.', 101, 1);
INSERT INTO profesor VALUES (2, 'Amariei', 'Ciprian', 'ciprian.amariei@info.uaic.ro', 'Prof', 101, 2);
INSERT INTO profesor VALUES (3, 'Farsinaru', 'Cristian', 'cristian.farsianru@info.uaic.ro', 'Lect.dr.', 101, 3);
INSERT INTO profesor VALUES (4, 'Moruz', 'Alex', 'alex.moruz@info.uaic.ro', 'Lect.dr.', 101, 4);
INSERT INTO profesor VALUES (5, 'Iftene', 'Adrian', 'adrian.iftene@info.uaic.ro', 'Decan', 101, 5);
INSERT INTO profesor VALUES (6, 'Iacob', 'Florin', 'florin.iacob@info.uaic.ro', 'Lect.dr.', 101, 6);
INSERT INTO profesor VALUES (7, 'Gimbuta', 'Raluca', 'raluca.gimbuta@info.uaic.ro', 'Assist.', 101, 7);
INSERT INTO profesor VALUES (8, 'Lazar', 'Lucian', 'lucian.lazar@info.uaic.ro', 'Assist.', 101, 8);
INSERT INTO profesor VALUES (9, 'Luchian', 'Stefan', 'stefan.luchian@info.uaic.ro', 'Assist.', 101, 9);
INSERT INTO profesor VALUES (10, 'Lenuta', 'Alboaie', 'lenuta.alboaie@info.uaic.ro', 'Prof.', 101, 10);
INSERT INTO profesor VALUES (11, 'Cosbuc', 'Mihai', 'mihai.cosbuc@info.uaic.ro', 'Prof.', 101, 16);
INSERT INTO profesor VALUES (12, 'George', 'Radulescu', 'george.radulescu@info.uaic.ro', 'ProDecan.', 101, 17);
INSERT INTO profesor VALUES (13, 'Cristian', 'Vidrascu', 'cristian.vidrascu@info.uaic.ro', 'Prof.', 101, 18);
INSERT INTO profesor VALUES (14, 'Florentin', 'Olariu', 'florentin.olariu@info.uaic.ro', 'Prof.', 101, 19);
INSERT INTO profesor VALUES (15, 'Dorel', 'Lucanu', 'dorel.lucanu@info.uaic.ro', 'Prof.', 101, 20);

  
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
INSERT INTO materie VALUES(12,'Programare Orientata',2,NULL);
INSERT INTO materie VALUES(13,'Statistica si Probabilitati',2,NULL);
INSERT INTO materie VALUES(14,'Sisteme de Operare',2,NULL);
INSERT INTO materie VALUES(15,'Arhitectura Calculatoarelor',2,NULL);
INSERT INTO materie VALUES(16,'Structuri de Date',2,NULL);
INSERT INTO materie VALUES(17,'Matematica',2,NULL);


INSERT INTO student VALUES(1,'Mitocariu','Emilian','emilian.mitocariu@info.uaic.ro',NULL,4,101,11);
INSERT INTO student VALUES(2,'Tacutanu','Vlad','vlad.tacutanu@info.uaic.ro',NULL,4,101,12);
INSERT INTO student VALUES(3,'Rusu','Ovidiu','ovidiu.rusu@info.uaic.ro',NULL,4,101,13);
INSERT INTO student VALUES(4,'Stoian','Sorin','sorin.stoian@info.uaic.ro',NULL,4,101,14);
INSERT INTO student VALUES(5,'Budai','Marian','marian.budai@info.uaic.ro',NULL,2,101,15);

INSERT INTO student_materie VALUES(1,1,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(1,2,'2014-10-01','Promovat');
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
INSERT INTO student_materie VALUES(5,12,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(5,13,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(5,14,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(5,15,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(5,16,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(5,17,'2015-02-14','In Curs');

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
INSERT INTO profesor_materie VALUES(6,17);
INSERT INTO profesor_materie VALUES(11,16);
INSERT INTO profesor_materie VALUES(12,15);
INSERT INTO profesor_materie VALUES(13,14);
INSERT INTO profesor_materie VALUES(14,13);
INSERT INTO profesor_materie VALUES(15,12);

INSERT INTO Assignment VALUES(1,7,'Tema1', NULL, '2015-02-15', '2015-02-22', 100, 'res/SGBD/Assignments/Exercitii_lab1.pdf');
INSERT INTO Assignment VALUES(2,7,'Tema2', NULL, '2015-02-22', '2015-03-01', 100, 'res/SGBD/Assignments/Exercitii_lab2.pdf');
INSERT INTO Assignment VALUES(3,7,'Tema3', NULL, '2015-03-01', '2015-03-08', 100, 'res/SGBD/Assignments/Exercitii_lab3.pdf');
INSERT INTO Assignment VALUES(4,7,'Tema4', NULL, '2015-03-08', '2015-03-15', 100, 'res/SGBD/Assignments/Exercitii_lab4.pdf');
INSERT INTO Assignment VALUES(5,7,'Tema5', NULL, '2015-03-15', '2015-03-22', 100, 'res/SGBD/Assignments/Exercitii_lab5.pdf');
INSERT INTO Assignment VALUES(6,7,'Tema6', NULL, '2015-03-22', '2015-03-29', 100, 'res/SGBD/Assignments/Exercitii_lab6.pdf');
INSERT INTO Assignment VALUES(7,7,'Tema7', NULL, '2015-03-29', '2015-04-05', 100, 'res/SGBD/Assignments/Exercitii_lab7.pdf');
INSERT INTO Assignment VALUES(8,7,'Tema8', NULL, '2015-04-05', '2015-04-12', 100, 'res/SGBD/Assignments/Exercitii_lab8.pdf');
INSERT INTO Assignment VALUES(9,7,'Tema9', NULL, '2015-04-12', '2015-04-19', 100, 'res/SGBD/Assignments/Exercitii_lab9.pdf');
INSERT INTO Assignment VALUES(10,7,'Tema10', NULL, '2015-04-19', '2015-04-26', 100, 'res/SGBD/Assignments/Exercitii_lab10.pdf');

INSERT INTO Submission VALUES(1, 3, 1,'2015-02-20', 'res/SGBD/Submissions/Rusu_Ovidiu_T1.zip');
INSERT INTO Submission VALUES(2, 2, 4,'2015-03-14', 'res/SGBD/Submissions/Vlad_Tacutanu_T4.txt');
INSERT INTO Submission VALUES(3, 2, 5,'2015-03-16', 'res/SGBD/Submissions/Vlad_Tacutanu_T5.txt');
INSERT INTO Submission VALUES(4, 2, 6,'2015-03-26', 'res/SGBD/Submissions/Vlad_Tacutanu_T6.txt');
INSERT INTO Submission VALUES(5, 2, 7,'2015-04-01', 'res/SGBD/Submissions/Vlad_Tacutanu_T7.sql');

INSERT INTO Nota VALUES(1, 1, 8, 10);
INSERT INTO Nota VALUES(2, 2, 8, 8);
INSERT INTO Nota VALUES(3, 3, 8, 10);
INSERT INTO Nota VALUES(4, 4, 8, 10);

INSERT INTO Resource VALUES(1, 'Conditii si bucle', 7, 'res/SGBD/Resources/Conditii si bucle.pdf');
INSERT INTO Resource VALUES(2, 'Variabile si blocuri', 7, 'res/SGBD/Resources/Variabile si blocuri.pdf');
INSERT INTO Resource VALUES(3, 'Cursoare', 7, 'res/SGBD/Resources/Cursoare.pdf');
INSERT INTO Resource VALUES(4, 'Proceduri stocate', 7, 'res/SGBD/Resources/Proceduri stocate.pdf');
INSERT INTO Resource VALUES(5, 'Exceptii', 7, 'res/SGBD/Resources/Exceptii.pdf');
INSERT INTO Resource VALUES(6, 'Dictionarul Oracle', 7, 'res/SGBD/Resources/Oracle Dictionary.pdf');
INSERT INTO Resource VALUES(7, 'Conditii si bucle', 7, 'res/SGBD/Resources/Conditii si bucle.pdf');
INSERT INTO Resource VALUES(8, 'Obiecte', 7, 'http://docs.oracle.com/cd/A97630_01/appdev.920/a96624/10_objs.htm');
