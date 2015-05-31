<?php
session_start();
include('connection.php');
$nume = $_POST['nume'];
$prenume = $_POST['prenume'];
$email = $_POST['email'];
$fac = $_POST['facultate'];
$matricol = $_POST['matricol'];
$semestru = $_POST['sem'];
$username = $_POST['username'];
$password = md5($_POST['pass']);
 
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
if($semestru == '') {
	$errmsg_arr[] = 'Nu ai introdus semestrul';
	$errflag = true;
}
if($username == '') {
	$errmsg_arr[] = 'Nu ai introdus username';
	$errflag = true;
}
if($password == '') {
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
$result2 = mysql_query("SELECT max(idstudent) AS maxid FROM student");
$row2 = mysql_fetch_array($result2);
$newid2 = $row2["maxid"] + 1;
mysql_query("INSERT INTO account VALUES ('$newid','$username','$password','S')");
mysql_query("INSERT INTO student VALUES ('$newid2','$nume','$prenume','$email','$matricol','$semestru',101,'$newid')");

header("location: index.html");
mysql_close($con);
?>