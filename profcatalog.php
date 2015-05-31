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
		$result = mysql_query("select idStudent, nume, prenume from Student order by nume");
		while($line = mysql_fetch_array($result, MYSQL_ASSOC)) {
			echo '<tr><td>',$line["nume"],' ',$line["prenume"],'</td>';
			$idstud = $line["idStudent"];
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
				if(is_null($line3["nota"])){
					echo '<td></td>';
				}else{
					echo '<td>',$line3["nota"],'</td>';
				}
			}
			echo '</tr>';
		}
        ?>
    </tbody>
  </table>
</body>  
</html>  