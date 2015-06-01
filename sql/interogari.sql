--lista cursuri pt studenti pe studentindex
SELECT materie.Nume, student_materie.StartDate FROM materie
 JOIN student_materie ON materie.IdMaterie=student_materie.IdMaterie
 JOIN student ON student_materie.IdStudent=student.IdStudent
 JOIN account ON student.IdAccount=account.IdAccount
 WHERE account.Username = '$username' AND student_materie.Status='In Curs';

 --notele unui student la o materie
 SELECT asssignment.titlu, nota.Nota from nota
  JOIN submission on nota.IdNota = submission.IdSubmission
  JOIN student on submission.IdStudent = student.IdStudent
  JOIN account ON student.IdAccount=account.IdAccount
  WHERE account.Username = '$username';

--lista assignment-uri la o materie
select assignment.titlu as t,assignment.path as p,assignment.duedate as d
from assignment JOIN materie ON materie.IdMaterie=assignment.IdMaterie 
where materie.nume='$numemat'

--notele studentului la assignment-urile de la o materie
SELECT A.t as titlu, A.p as path, A.d as due, B.n as nota FROM (select assignment.IdAssignment as id, assignment.titlu as t,assignment.path as p,assignment.duedate as d
from assignment JOIN materie ON materie.IdMaterie=assignment.IdMaterie 
where materie.nume='$numemat') AS A
LEFT JOIN
 (select assignment.IdAssignment as id, nota.Nota as n from assignment
JOIN materie ON materie.IdMaterie=assignment.IdMaterie
JOIN submission ON submission.IdAssignment = assignment.IdAssignment
Join nota on submission.IdSubmission = nota.IdSubmission
join student on submission.IdStudent = student.IdStudent
join account on student.IdAccount = account.IdAccount
where materie.nume='$numemat'
and account.Username = '$username') AS B
ON A.id = B.id;

--submission-urile trimise la timp, afisate pe pagina profului
SELECT student.Nume as nume, student.Prenume as prenume,
        assignment.Titlu as titlu, submission.Data, submission.Path as path
        FROM student join submission on student.IdStudent = submission.IdStudent
        JOIN assignment on submission.IdAssignment = assignment.IdAssignment
        WHERE submission.Data < assignment.DueDate
		ORDER BY submission.Data DESC;


--
select assignment.idassignment, submission.IdSubmission, student.nume, nota.Nota from assignment
left join submission on assignment.IdAssignment=submission.IdSubmission
left join Student on Student.idStudent=submission.idStudent
left join nota on submission.IdSubmission=nota.IdSubmission
where student.IdStudent=2 or submission.IdSubmission <=> NULL

--studentii activi la materia Data
select student.IdStudent, student.Nume from student 
left join student_materie on student.IdStudent=student_materie.IdStudent
left join materie on student_materie.IdMaterie = materie.IdMaterie
where student_materie.Status='In Curs'
and materie.Nume='SGBD'

--nr. de studenti care vor aparea in raport
select count(student.IdStudent) from student
left join student_materie on student.IdStudent=student_materie.IdStudent
left join materie on student_materie.IdMaterie = materie.IdMaterie
where student_materie.Status='In Curs'
and materie.Nume='SGBD'