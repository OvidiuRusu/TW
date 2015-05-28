<?php
session_start();
if(isset($_POST['submit'])){
    move_uploaded_file ($_FILES['uploadFile']['tmp_name'], "res/".$_SESSION['numemat']."/Submissions/{$_FILES['uploadFile']['name']}");
	include('connection.php');
	$result = mysql_query("select max(idsubmission) as id from submission;");
	$line = mysql_fetch_array($result, MYSQL_ASSOC);
	$idsub=$line["id"]+1;
	$username=$_SESSION['username'];
	$result = mysql_query("select student.idstudent as id from student JOIN account ON account.idaccount=student.idaccount where account.Username='$username';");
	$line = mysql_fetch_array($result, MYSQL_ASSOC);
	$idstud=$line["id"];
	$numeassign=$_POST['numetema'];
	$data=date("Y-m-d");
	$path="res/".$_SESSION['numemat']."/Submissions/{$_FILES['uploadFile']['name']}";
	$result=mysql_query("select idassignment as id from assignment where titlu='$numeassign'");
	$line = mysql_fetch_array($result, MYSQL_ASSOC);
	$id = $line["id"];
	mysql_query("INSERT INTO submission VALUES ('$idsub','$idstud','$id','$data','$path')");
	print "Upload reusit.";
	echo '<meta http-equiv=REFRESH CONTENT=3;url="studentcourse.php?name=',$_SESSION['numemat'],'">';
}
 ?>