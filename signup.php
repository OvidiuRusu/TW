<!DOCTYPE html>
<?php
session_start();
?>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title>Student Sign-Up</title>
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
    <form action="reg.php" method="post">
      <input type="text" name="nume" placeholder="Nume">
      <input type="text" name="prenume" placeholder="Prenume">
      <input type="text" name="email" placeholder="Email">

      <!-- lista cu facultatile in loc de type="text" -->
      <input type="text" name="facultate" placeholder="Facultate">

      <input type="text" name="matricol" placeholder="Numar matricol">
      <input type="text" name="sem" placeholder="Semestru">
      <input type="text" name="username" placeholder="Username">
      <input type="password" name="pass" placeholder="Password">
      <input type="submit" name="signup" class="login login-submit" value="Sign up">
    </form>
      <?php
if(isset($_SESSION['ERRMSG_ARR']) && is_array($_SESSION['ERRMSG_ARR']) &&  count($_SESSION['ERRMSG_ARR']) >0 ) {
  foreach($_SESSION['ERRMSG_ARR'] as $msg) {
    echo '<p style="color: red">',$msg,'</p>'; 
  }
  unset($_SESSION['ERRMSG_ARR']);
}
?>
  </div>
</div>
</div>
</body>
</html>