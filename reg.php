<?php
session_start();
include('connection.php');
 //nume prenume email facultate matricol username password
$nume = $_POST['nume'];
$prenume = $_POST['prenume'];
$email = $_POST['email'];
$fac = $_POST['facultate'];
$matricol = $_POST['matricol'];
$username = $_POST['username'];
$password = $_POST['pass'];
 
if($nume == '') {
	$errmsg_arr[] = 'Nu ai introdus nume';
	$errflag = true;
}
if($prenume == '') {
	$errmsg_arr[] = 'Nu ai introdus prenume';
	$errflag = true;
}
if($email == '') {
	$errmsg_arr[] = 'Nu ai introdus email';
	$errflag = true;
}
if($fac == '') {
	$errmsg_arr[] = 'Nu ai introdus facultatea';
	$errflag = true;
}
if($matricol == '') {
	$errmsg_arr[] = 'Nu ai introdus matricol';
	$errflag = true;
}
if($email == '') {
	$errmsg_arr[] = 'Nu ai introdus username';
	$errflag = true;
}
if($email == '') {
	$errmsg_arr[] = 'Nu ai introdus parola';
	$errflag = true;
}
if($errflag) {
	$_SESSION['ERRMSG_ARR'] = $errmsg_arr;
	session_write_close();
	header("location: signup.php");
	exit();
}
$result = mysql_query("SELECT max(idaccount) AS maxid FROM account");
$row = mysql_fetch_array($result);
$newid = $row["maxid"] + 1;
mysql_query("INSERT INTO account VALUES ('$newid','$username','$password','S')");

/*$sql = "INSERT INTO members (fname,lname,age) VALUES (:sas,:asas,:asafs)";
$q = $conn->prepare($sql);
$q->execute(array(':sas'=>$fname,':asas'=>$lname,':asafs'=>$age));*/
header("location: index.html");
mysql_close($con);
?>