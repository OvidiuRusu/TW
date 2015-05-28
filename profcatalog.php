<!DOCTYPE html>
<?php 
  session_start();
  include('connection.php');
  if (!isset($_SESSION['username']) || empty($_SESSION['username'])) {
    exit();
  }
  $username = $_SESSION['username'];
  $numemat=$_GET["name"];
?>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><?php echo $numemat?></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="style.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div id="header">
  <h1><img src="images/oamlogo3.png" alt="" />Online <span style="font-weight:bold; color:#73868C;">Assignment</span> Manager</h1>
</div>
<div id="container">
    <ul id="nav">
	  <li><a href="index.html">Logout</a></li>
      <li><a href="profindex.php"><?php echo $username ?></a></li>
    </ul>
  <div id="contentleft">
    <ul id="nav2">
      <li><a href="profesorcourse.php?name=<?php print $numemat?>">Assigments</a></li>
      <li><a href="profsubs.php?name=<?php print $numemat?>">Submissions</a></li>
      <li><a href="#" style="color: #000;">Catalog</a></li>
    </ul>  
    <table style="margin-left: 5px">
      <thead>
        <tr>
          <th>Nume Student</th>
          <?php
          $result = mysql_query("SELECT assignment.titlu as nume FROM assignment JOIN materie on assignment.idmaterie = materie.idmaterie WHERE materie.nume='$numemat'");
          while($line = mysql_fetch_array($result, MYSQL_ASSOC)) {
            echo '<th>',$line["nume"],'</th>';
          }
            ?>
      </thead>
      <tbody>
        
      </tbody>
    </table>
  </div>
</div>
</body>
</html>