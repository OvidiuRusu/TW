<?php
session_start();
if(isset($_POST['submit'])){
	$numeassign=$_POST['numetema'];
	if($numeassign=='Proiect' and $_SESSION['medie']<5){
		print "Upload nereusit.";
	}else{
		move_uploaded_file ($_FILES['uploadFile']['tmp_name'], "res/".$_SESSION['numemat']."/Submissions/{$_FILES['uploadFile']['name']}");
		include('connection.php');
		$result = mysql_query("select max(idsubmission) as id from submission;");
		$line = mysql_fetch_array($result, MYSQL_ASSOC);
		$idsub=$line["id"]+1;
		$username=$_SESSION['username'];
		$result = mysql_query("select student.idstudent as id from student JOIN account ON account.idaccount=student.idaccount where account.Username='$username';");
		$line = mysql_fetch_array($result, MYSQL_ASSOC);
		$idstud=$line["id"];
		$data=date("Y-m-d");
		$path="res/".$_SESSION['numemat']."/Submissions/{$_FILES['uploadFile']['name']}";
		$numemat=$_SESSION['numemat'];
		$result=mysql_query("select assignment.idassignment as id from assignment 
								join materie on materie.idmaterie=assignment.idmaterie 
								where assignment.titlu='$numeassign' and materie.nume='$numemat'");
		$line = mysql_fetch_array($result, MYSQL_ASSOC);
		$id = $line["id"];
		mysql_query("INSERT INTO submission VALUES ('$idsub','$idstud','$id','$data','$path')");
		print "Upload reusit.";
	}
	$mat = $_SESSION['numemat'];
	$mat = str_replace(" ","%20",$mat);
	echo '<meta http-equiv=REFRESH CONTENT=3;url="studentcourse.php?name=',$mat,'">';
}
 ?>