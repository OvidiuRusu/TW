<?php
session_start();
if(isset($_POST['submit'])){
    move_uploaded_file ($_FILES['uploadFile']['tmp_name'], "res/".$_SESSION['numemat']."/Resources/{$_FILES['uploadFile']['name']}");
	include('connection.php');
	$result = mysql_query("select max(idresursa) as id from resource;");
	$line = mysql_fetch_array($result, MYSQL_ASSOC);
		$idres=$line["id"]+1;
		
	$numemat=$_SESSION['numemat'];
	$result = mysql_query("select idmaterie as id from materie where nume='$numemat';");
	$line = mysql_fetch_array($result, MYSQL_ASSOC);
		$idmat=$line["id"];
		
	$nume=$_POST['nume'];
	$path="res/".$_SESSION['numemat']."/Resources/{$_FILES['uploadFile']['name']}";
	mysql_query("INSERT INTO resource VALUES ('$idres','$nume','$idmat','$path')");
	print "Upload reusit.";
}
 ?>