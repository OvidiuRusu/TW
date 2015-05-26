--lista cursuri pt studenti pe studentindex
SELECT materie.Nume, student_materie.StartDate FROM materie JOIN student_materie ON materie.IdMaterie=student_materie.IdMaterie
 JOIN student ON student_materie.IdStudent=student.IdStudent
 JOIN account ON student.IdAccount=account.IdAccount
 WHERE account.Username = '$username' AND student_materie.Status='In Curs';

 --notele unui student la o materie
 SELECT student.Nume, nota.Nota from nota
  join submission on nota.IdNota = submission.IdSubmission
  join student on submission.IdStudent = student.IdStudent;