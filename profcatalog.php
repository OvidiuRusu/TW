 <!DOCTYPE html>
 <?php 
session_start();
include('connection.php');
if (!isset($_SESSION['username']) || empty($_SESSION['username'])) {
	exit();
}
$username = $_SESSION['username'];
$numemat=$_SESSION['numemat'];
?>
<head>
  <link href="table.css" rel="stylesheet" type="text/css" />
  <title>Catalog</title>
 </head>
 <body> 
 <table>
    <thead>
      <tr>
        <th>Student Name</th>
		<?php
		$result = mysql_query("select assignment.titlu as titlu from assignment 
									join materie on materie.idMaterie=assignment.idMaterie 
									where materie.nume = '$numemat'");
		while($line = mysql_fetch_array($result, MYSQL_ASSOC)) {
			echo '<th>',$line["titlu"],'</th>';
		}
		?>
      </tr>
    </thead>
  <tbody>
        <?php
		//$result = mysql_query("select idStudent, nume, prenume from Student order by nume");
		$result = mysql_query("select student.IdStudent as idstud, student.Nume as nume, student.prenume as prenume from student 
			left join student_materie on student.IdStudent=student_materie.IdStudent
			left join materie on student_materie.IdMaterie = materie.IdMaterie
			where student_materie.Status='In Curs'
			and materie.Nume='$numemat'");
		$rand=0;
		while($line = mysql_fetch_array($result, MYSQL_ASSOC)) {
			$rand=$rand+1;
			if($rand % 2 == 0){
				echo '<tr><td style="font-weight: bold;">',$line["nume"],' ',$line["prenume"],'</td>';
			}else{
				echo '<tr><td bgcolor="#C4E6E6" style="font-weight: bold;">',$line["nume"],' ',$line["prenume"],'</td>';
			}
			$idstud = $line["idstud"];
			$result2 = mysql_query("select assignment.IdAssignment as idassign from assignment 
										join materie on materie.idMaterie=assignment.idMaterie 
										where materie.nume = '$numemat'");
			while($line2 = mysql_fetch_array($result2, MYSQL_ASSOC)){
				$idassign = $line2["idassign"];
				$result3 = mysql_query("select nota.Nota as nota from nota
											join submission on submission.IdSubmission=nota.IdSubmission
											join assignment on assignment.IdAssignment=submission.IdAssignment
											where assignment.IdAssignment=$idassign and submission.IdStudent=$idstud");
				$line3 = mysql_fetch_array($result3, MYSQL_ASSOC);
				if($rand % 2 == 0){
					if(is_null($line3["nota"])){
						echo '<td></td>';
					}else{
						echo '<td>',$line3["nota"],'</td>';
					}
				}else{
					if(is_null($line3["nota"])){
						echo '<td bgcolor="#C4E6E6"></td>';
					}else{
						echo '<td bgcolor="#C4E6E6">',$line3["nota"],'</td>';
					}
				}
			}
			echo '</tr>';
		}
        ?>
    </tbody>
  </table>
</body>  
</html>  