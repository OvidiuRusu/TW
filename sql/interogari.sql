--lista cursuri pt studenti pe studentindex
SELECT materie.Nume, student_materie.StartDate FROM materie JOIN student_materie ON materie.IdMaterie=student_materie.IdMaterie
 JOIN student ON student_materie.IdStudent=student.IdStudent
 JOIN account ON student.IdAccount=account.IdAccount
 WHERE account.Username = '$username' AND student_materie.Status='In Curs';