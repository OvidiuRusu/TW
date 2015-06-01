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
INSERT INTO account VALUES (20, 'paul.hodoreanu', 'parola', 'S');
INSERT INTO account VALUES (21, 'florin.finaru', 'parola', 'S');
INSERT INTO account VALUES (22, 'paul.benkdo', 'parola', 'S');
INSERT INTO account VALUES (23, 'ana.petrita', 'parola', 'S');
INSERT INTO account VALUES (24, 'andreea.condruta', 'parola', 'S');
INSERT INTO account VALUES (25, 'rares.drugu', 'parola', 'S');
INSERT INTO account VALUES (26, 'andrei.papara', 'parola', 'S');
INSERT INTO account VALUES (27, 'alexandru.rusu', 'parola', 'S');
INSERT INTO account VALUES (28, 'vlad.lihaceanu', 'parola', 'S');
INSERT INTO account VALUES (29, 'dragos.ivan', 'parola', 'S');
INSERT INTO account VALUES (30, 'nicolae.berendea', 'parola', 'S');
INSERT INTO account VALUES (31, 'dacian.spanu', 'parola', 'S');

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
INSERT INTO student VALUES(6,'Hodoreanu','Paul','paul.hodoreanu@info.uaic.ro',NULL,4,101,20);
INSERT INTO student VALUES(7,'Finaru','Florin','florin.finaru@info.uaic.ro',NULL,4,101,21);
INSERT INTO student VALUES(8,'Benko','Paul','paul.benkdo@info.uaic.ro',NULL,4,101,22);
INSERT INTO student VALUES(9,'Petrita','Ana','ana.petrita@info.uaic.ro',NULL,4,101,23);
INSERT INTO student VALUES(10,'Codruta','Andreea','andreea.condruta@info.uaic.ro',NULL,4,101,24);
INSERT INTO student VALUES(11,'Drugu','Rares','rares.drugu@info.uaic.ro',NULL,4,101,25);
INSERT INTO student VALUES(12,'Papara','Andrei','andrei.papara@info.uaic.ro',NULL,4,101,26);
INSERT INTO student VALUES(13,'Rusu','Alexandru','alexandru.rusu@info.uaic.ro',NULL,4,101,27);
INSERT INTO student VALUES(14,'Lihaceanu','Vlad','vlad.lihaceanu@info.uaic.ro',NULL,4,101,28);
INSERT INTO student VALUES(15,'Ivan','Dragos','dragos.ivan@info.uaic.ro',NULL,4,101,29);
INSERT INTO student VALUES(16,'Bereandea','Nicolae','nicolae.berendea@info.uaic.ro',NULL,4,101,30);
INSERT INTO student VALUES(17,'Spanu','Dacian','dacian.spanu@info.uaic.ro',NULL,4,101,31);


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
INSERT INTO student_materie VALUES(6,1,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(6,2,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(6,3,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(6,4,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(6,5,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(6,6,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(6,7,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(6,8,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(6,9,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(6,10,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(6,11,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(6,12,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(6,13,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(6,14,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(6,15,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(6,16,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(6,17,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(7,1,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(7,2,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(7,3,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(7,4,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(7,5,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(7,6,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(7,7,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(7,8,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(7,9,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(7,10,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(7,11,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(7,12,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(7,13,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(7,14,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(7,15,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(7,16,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(7,17,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(8,1,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(8,2,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(8,3,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(8,4,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(8,5,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(8,6,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(8,7,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(8,8,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(8,9,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(8,10,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(8,11,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(8,12,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(8,13,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(8,14,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(8,15,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(8,16,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(8,17,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(9,6,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(9,7,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(9,8,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(9,9,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(9,10,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(9,11,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(10,6,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(10,7,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(10,8,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(10,9,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(10,10,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(10,11,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(11,6,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(11,7,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(11,8,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(11,9,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(11,10,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(11,11,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(12,6,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(12,7,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(12,8,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(12,9,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(12,10,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(12,11,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(13,6,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(13,7,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(13,8,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(13,9,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(13,10,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(13,11,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(14,6,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(14,7,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(14,8,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(14,9,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(14,10,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(14,11,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(15,6,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(15,7,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(15,8,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(15,9,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(15,10,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(15,11,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(16,6,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(16,7,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(16,8,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(16,9,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(16,10,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(16,11,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(17,6,'2014-10-01','Promovat');
INSERT INTO student_materie VALUES(17,7,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(17,8,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(17,9,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(17,10,'2015-02-14','In Curs');
INSERT INTO student_materie VALUES(17,11,'2015-02-14','In Curs');


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

INSERT INTO Assignment VALUES(1,7,'Tema1', NULL, '2015-02-15', '2015-02-22', 10, 'res/SGBD/Assignments/Exercitii_lab1.pdf');
INSERT INTO Assignment VALUES(2,7,'Tema2', NULL, '2015-02-22', '2015-03-01', 10, 'res/SGBD/Assignments/Exercitii_lab2.pdf');
INSERT INTO Assignment VALUES(3,7,'Tema3', NULL, '2015-03-01', '2015-03-08', 10, 'res/SGBD/Assignments/Exercitii_lab3.pdf');
INSERT INTO Assignment VALUES(4,7,'Tema4', NULL, '2015-03-08', '2015-03-15', 10, 'res/SGBD/Assignments/Exercitii_lab4.pdf');
INSERT INTO Assignment VALUES(5,7,'Tema5', NULL, '2015-03-15', '2015-03-22', 10, 'res/SGBD/Assignments/Exercitii_lab5.pdf');
INSERT INTO Assignment VALUES(6,7,'Tema6', NULL, '2015-03-22', '2015-03-29', 10, 'res/SGBD/Assignments/Exercitii_lab6.pdf');
INSERT INTO Assignment VALUES(7,7,'Tema7', NULL, '2015-03-29', '2015-04-05', 10, 'res/SGBD/Assignments/Exercitii_lab7.pdf');
INSERT INTO Assignment VALUES(8,7,'Tema8', NULL, '2015-04-05', '2015-04-12', 10, 'res/SGBD/Assignments/Exercitii_lab8.pdf');
INSERT INTO Assignment VALUES(9,7,'Tema9', NULL, '2015-04-12', '2015-04-19', 10, 'res/SGBD/Assignments/Exercitii_lab9.pdf');
INSERT INTO Assignment VALUES(10,7,'Tema10', NULL, '2015-04-19', '2015-04-26', 10, 'res/SGBD/Assignments/Exercitii_lab10.pdf');

INSERT INTO Assignment VALUES(11,10,'Lab1', NULL, '2015-02-15', '2015-02-22', 10, 'res/Ingineria Programarii/Assignments/Lab01.pdf');
INSERT INTO Assignment VALUES(12,10,'Lab2', NULL, '2015-02-22', '2015-03-01', 10, 'res/Ingineria Programarii/Assignments/Lab02.pdf');
INSERT INTO Assignment VALUES(13,10,'Lab3', NULL, '2015-03-01', '2015-03-08', 10, 'res/Ingineria Programarii/Assignments/Lab03.pdf');
INSERT INTO Assignment VALUES(14,10,'Lab4', NULL, '2015-03-08', '2015-03-15', 10, 'res/Ingineria Programarii/Assignments/Lab04.pdf');
INSERT INTO Assignment VALUES(15,10,'Lab5', NULL, '2015-03-15', '2015-03-22', 10, 'res/Ingineria Programarii/Assignments/Lab05.pdf');
INSERT INTO Assignment VALUES(16,10,'Lab6', NULL, '2015-03-22', '2015-03-29', 10, 'res/Ingineria Programarii/Assignments/Lab06.pdf');
INSERT INTO Assignment VALUES(17,10,'Lab7', NULL, '2015-03-29', '2015-04-05', 10, 'res/Ingineria Programarii/Assignments/Lab07.pdf');
INSERT INTO Assignment VALUES(18,10,'Lab8', NULL, '2015-04-05', '2015-04-12', 10, 'res/Ingineria Programarii/Assignments/Lab08.pdf');
INSERT INTO Assignment VALUES(19,10,'Proiect', NULL, '2015-04-12', '2015-04-19', 10, 'res/Ingineria Programarii/Assignments/Proiect.pdf');


INSERT INTO Submission VALUES(1, 3, 1,'2015-02-20', 'res/SGBD/Submissions/Rusu_Ovidiu_T1.zip');
INSERT INTO Submission VALUES(2, 2, 4,'2015-03-14', 'res/SGBD/Submissions/Vlad_Tacutanu_T4.txt');
INSERT INTO Submission VALUES(3, 2, 5,'2015-03-16', 'res/SGBD/Submissions/Vlad_Tacutanu_T5.txt');
INSERT INTO Submission VALUES(4, 2, 6,'2015-03-26', 'res/SGBD/Submissions/Vlad_Tacutanu_T6.txt');
INSERT INTO Submission VALUES(5, 2, 7,'2015-04-01', 'res/SGBD/Submissions/Vlad_Tacutanu_T7.sql');
INSERT INTO Submission VALUES(6, 17, 11,'2015-03-14', 'res/Ingineria Programarii/Submissions/BingTranslator.java');
INSERT INTO Submission VALUES(7, 17, 11,'2015-03-16', 'res/Ingineria Programarii/Submissions/ColectiaMea.java');
INSERT INTO Submission VALUES(8, 16, 11,'2015-03-14', 'res/Ingineria Programarii/Submissions/Dictio.java');
INSERT INTO Submission VALUES(9, 16, 11,'2015-03-26', 'res/Ingineria Programarii/Submissions/Film.java');
INSERT INTO Submission VALUES(10, 14, 12,'2015-03-14', 'res/Ingineria Programarii/Submissions/GoogleTranslate.java');
INSERT INTO Submission VALUES(11, 14, 13,'2015-03-16', 'res/Ingineria Programarii/Submissions/Hallo.java');
INSERT INTO Submission VALUES(12, 13, 12,'2015-03-14', 'res/Ingineria Programarii/Submissions/Manage.java');
INSERT INTO Submission VALUES(13, 13, 14,'2015-03-16', 'res/Ingineria Programarii/Submissions/MyException.java');


INSERT INTO Nota VALUES(1, 1, 8, 10);
INSERT INTO Nota VALUES(2, 2, 8, 8);
INSERT INTO Nota VALUES(3, 3, 8, 10);
INSERT INTO Nota VALUES(4, 4, 8, 10);
INSERT INTO Nota VALUES(5, 6, 5, 7);
INSERT INTO Nota VALUES(6, 8, 5, 9);
INSERT INTO Nota VALUES(7, 9, 5, 8);
INSERT INTO Nota VALUES(8, 12, 5, 10);
INSERT INTO Nota VALUES(9, 13, 5, 9);


INSERT INTO Resource VALUES(1, 'Conditii si bucle', 7, 'res/SGBD/Resources/Conditii si bucle.pdf');
INSERT INTO Resource VALUES(2, 'Variabile si blocuri', 7, 'res/SGBD/Resources/Variabile si blocuri.pdf');
INSERT INTO Resource VALUES(3, 'Cursoare', 7, 'res/SGBD/Resources/Cursoare.pdf');
INSERT INTO Resource VALUES(4, 'Proceduri stocate', 7, 'res/SGBD/Resources/Proceduri stocate.pdf');
INSERT INTO Resource VALUES(5, 'Exceptii', 7, 'res/SGBD/Resources/Exceptii.pdf');
INSERT INTO Resource VALUES(6, 'Dictionarul Oracle', 7, 'res/SGBD/Resources/Oracle Dictionary.pdf');
INSERT INTO Resource VALUES(7, 'Conditii si bucle', 7, 'res/SGBD/Resources/Conditii si bucle.pdf');
INSERT INTO Resource VALUES(8, 'Obiecte', 7, 'http://docs.oracle.com/cd/A97630_01/appdev.920/a96624/10_objs.htm');

INSERT INTO Resource VALUES(9, 'Introducere', 10, 'res/Ingineria Programarii/Resources/IP_Introducere.pdf');
INSERT INTO Resource VALUES(10, 'Motivatie si Definitii', 10, 'res/Ingineria Programarii/Resources/IP01.pdf');
INSERT INTO Resource VALUES(11, 'Modele de dezvoltare', 10, 'res/Ingineria Programarii/Resources/IP02.pdf');
INSERT INTO Resource VALUES(12, 'Reverse Engineering', 10, 'res/Ingineria Programarii/Resources/IP03.pdf');
INSERT INTO Resource VALUES(13, 'Diagrame', 10, 'res/Ingineria Programarii/Resources/IP04.pdf');
INSERT INTO Resource VALUES(14, 'Design Patterns', 10, 'res/Ingineria Programarii/Resources/IP05.pdf');
INSERT INTO Resource VALUES(15, 'Creational Patterns', 10, 'res/Ingineria Programarii/Resources/IP06.pdf');
INSERT INTO Resource VALUES(16, 'Behavioral Patterns', 10, 'res/Ingineria Programarii/Resources/IP07.pdf');
INSERT INTO Resource VALUES(17, 'Modelare', 10, 'res/Ingineria Programarii/Resources/IP08.pdf');