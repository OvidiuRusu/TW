INSERT INTO universitate VALUES(1,'Univ. Al. I. Cuza');

INSERT INTO facultate VALUES(101,'Facultatea de Informatica', 1);

INSERT INTO account(IdAccount, Username, Password, Tip) VALUES (1, 'sabin.buraga', 'sunt_sefu', 'P');
INSERT INTO account(IdAccount, Username, Password, Tip) VALUES (2, 'ciprian.amariei', 'parola', 'P');
INSERT INTO account(IdAccount, Username, Password, Tip) VALUES (3, 'cristian.farsianru', 'parola', 'P');
INSERT INTO account(IdAccount, Username, Password, Tip) VALUES (4, 'alex.moruz', 'parola', 'P');
INSERT INTO account(IdAccount, Username, Password, Tip) VALUES (5, 'adrian.iftene', 'parola', 'P');
INSERT INTO account(IdAccount, Username, Password, Tip) VALUES (6, 'florin.iacob', 'parola', 'P');
INSERT INTO account(IdAccount, Username, Password, Tip) VALUES (7, 'raluca.gimbuta', 'parola', 'P');
INSERT INTO account(IdAccount, Username, Password, Tip) VALUES (8, 'lucian.lazar', 'parola', 'P');

INSERT INTO profesor(IdProfesor, Nume, Prenume, Email, Titlu, IdFacultate, IdAccount) VALUES (1, 'Buraga', 'Sabin', 'sabin.buraga@info.uaic.ro', 'Conf.dr.', 1, 1);
INSERT INTO profesor(IdProfesor, Nume, Prenume, Email, Titlu, IdFacultate, IdAccount) VALUES (2, 'Amariei', 'Ciprian', 'ciprian.amariei@info.uaic.ro', 'Prof', 1, 2);
INSERT INTO profesor(IdProfesor, Nume, Prenume, Email, Titlu, IdFacultate, IdAccount) VALUES (3, 'Farsinaru', 'Cristian', 'cristian.farsianru@info.uaic.ro', 'Lect.dr.', 1, 3);
INSERT INTO profesor(IdProfesor, Nume, Prenume, Email, Titlu, IdFacultate, IdAccount) VALUES (4, 'Moruz', 'Alex', 'alex.moruz@info.uaic.ro', 'Lect.dr.', 1, 4);
INSERT INTO profesor(IdProfesor, Nume, Prenume, Email, Titlu, IdFacultate, IdAccount) VALUES (5, 'Iftene', 'Adrian', 'adrian.iftene@info.uaic.ro', 'Decan', 1, 5);
INSERT INTO profesor(IdProfesor, Nume, Prenume, Email, Titlu, IdFacultate, IdAccount) VALUES (6, 'Iacob', 'Florin', 'florin.iacob@info.uaic.ro', 'Lect.dr.', 1, 6);
INSERT INTO profesor(IdProfesor, Nume, Prenume, Email, Titlu, IdFacultate, IdAccount) VALUES (7, 'Gimbuta', 'Raluca', 'raluca.gimbuta@info.uaic.ro', 'Assist.', 1, 7);
INSERT INTO profesor(IdProfesor, Nume, Prenume, Email, Titlu, IdFacultate, IdAccount) VALUES (8, 'Lazar', 'Lucian', 'lucian.lazar@info.uaic.ro', 'Assist.', 1, 8);

  
  
INSERT INTO materie VALUES(1,'Algoritmi Genetici',NULL);
INSERT INTO materie VALUES(2,'Limbaje formale, automate si compilatoare',NULL);
INSERT INTO materie VALUES(3,'Retele',NULL);
INSERT INTO materie VALUES(4,'Baze de date',NULL);
INSERT INTO materie VALUES(5,'Algoritmica Grafurilor',NULL);
INSERT INTO materie VALUES(6,'Limba Engleza III',NULL);
INSERT INTO materie VALUES(7,'SGBD',NULL);
INSERT INTO materie VALUES(8,'Tehnologii Web',NULL);
INSERT INTO materie VALUES(9,'Programare Logica',NULL);
INSERT INTO materie VALUES(10,'Ingineria Programarii',NULL);
INSERT INTO materie VALUES(11,'Programare Avansata',NULL);