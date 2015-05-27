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
      <li><a href="#" style="color: #000;">Submissions</a></li>
      <li><a href="#">Catalog</a></li>
    </ul>  
    <table style="width: 400px; margin-left: 5px;">
      <thead>
        <tr>
          <th>Assignment</th>
          <th>Nume Student</th>
          <th>Fisier</th>
        </tr>
      </thead>
      <tbody>
	  <?php
		$result = mysql_query("SELECT student.Nume as nume, student.Prenume as prenume,
        assignment.Titlu as titlu, submission.Data, submission.Path as path
        FROM student join submission on student.IdStudent = submission.IdStudent
        JOIN assignment on submission.IdAssignment = assignment.IdAssignment
        WHERE submission.Data < assignment.DueDate
        ORDER BY submission.Data DESC;");
		while($line = mysql_fetch_array($result, MYSQL_ASSOC)) {
        $den = end(explode('/', $line["path"]));
	  echo '<tr>
        <td>',$line["titlu"],'</td>
        <td>',$line["nume"],' ',$line["prenume"],'</td>
        <td><a href="',$line["path"],'">',$den,'</a></td>
      </tr>';
      }
      ?>
      
      </tbody>
    </table>

    <!-- adaugare formular pentru inserare note in contentright-->
  </div>
</div>
</body>
</html>