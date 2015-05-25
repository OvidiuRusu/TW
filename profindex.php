<!DOCTYPE html>
<?php 
  session_start();
  include('connection.php');
  if (!isset($_SESSION['username']) || empty($_SESSION['username'])) {
    exit();
  }
  $username = $_SESSION['username'];  
?>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">  
<title>OAM</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="style.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div id="header">
  <h1><img src="images/oamlogo3.png" alt="" />Online <span style="font-weight:bold; color:#73868C;">Assignment</span> Manager</h1>
</div>
<div id="container">
	<div id="navcontainer">
    <ul id="nav">
      <li id="nav-1"><a href="index.html">ProfName</a></li>
      <li id="nav-2"><a href="login.html">My Courses</a></li>
      <li id="nav-3"><a href="#">Courses List</a></li>
    </ul>
  </div>
  <div id="courses">
  	<ul id="coursenav">
	<?php
    $result = mysql_query("SELECT materie.Nume as n FROM materie JOIN profesor_materie ON materie.IdMaterie=profesor_materie.IdMaterie 
								JOIN profesor ON profesor_materie.Idprofesor=profesor.Idprofesor 
								JOIN account ON profesor.IdAccount=account.IdAccount WHERE account.Username = '$username';");
    while($line = mysql_fetch_array($result, MYSQL_ASSOC)) {
	?>
		<li><h3><a href="profesorcourse.php"><?php print $line["n"]?></a></li></h3>
    <?php }?>
  	</ul>
  </div>  		  