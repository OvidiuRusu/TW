<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title>Login</title>
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
      <li><a href="signup.php">Sign Up</a></li>
      <li><a href="login.php">Login</a></li>
      <li><a href="index.html">How it Works</a></li>
    </ul>
  </div>
<div id="content">
  <div class="login-card">
    <form method="post">
      <input type="text" name="user" placeholder="Username">
      <input type="password" name="pass" placeholder="Password">
      <input type="submit" name="login" class="login login-submit" value="Login">
    </form>
	
	<?php
		if (isset($_REQUEST["user"]) and isset($_REQUEST["pass"])){			
			require_once('clasabd.php');
			$bd = new DataBase_MySQL ('localhost', 'TW', 'root', '');
			$bd->connect(); 
			$bd->query("select username,password,tip from account;");
			$success=0;
			while ($bd->next_record()) {
				if($bd->Record["username"]==$_REQUEST["user"] && $bd->Record["password"]==md5($_REQUEST["pass"])) {
					$success=1;
					$tip=$bd->Record["tip"];
				}
			}
			if($success==1){
				session_start();
				$_SESSION['username'] = $_REQUEST["user"]; 
				if($tip=="P") {					
					header("Location: profindex.php");
				}
				if($tip=="S"){
					header("Location: studentindex.php");
				}
			}else{
				echo '<strong> Cont sau parola incorecta </strong>'; 
			}
		}
	?>
	
    <div class="login-help">
      <a href="#">Forgot Password?</a>
    </div>
  </div>
</div>
</div>
</body>
</html>