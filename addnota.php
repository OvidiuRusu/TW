<?php
	//inseram in baza de date o noua nota preluata dintr-un formular prin intermediul unui buton
	session_start();
	$username = $_SESSION['username'];
	if(isset($_POST['nota'])){
		include('connection.php');
		$result = mysql_query("select profesor.IdProfesor as idprof from profesor join account on profesor.IdAccount=account.IdAccount where account.Username='$username';");
		$line = mysql_fetch_array($result, MYSQL_ASSOC);
		$idprof=$line["idprof"];
		$result = mysql_query("select max(idnota) as idnota from nota;");
		$line = mysql_fetch_array($result, MYSQL_ASSOC);
		$idnota=$line["idnota"]+1;
		$idsub=$_POST['idsub'];
		$nota=(int)$_POST['nota'];
		mysql_query("INSERT INTO nota VALUES ('$idnota','$idsub','$idprof','$nota')");
		header("Location: profsubs.php?name=".$_SESSION['numemat']);
	}
?>