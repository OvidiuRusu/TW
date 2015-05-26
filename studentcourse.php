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
      <li><a href="studentindex.php"><?php echo $username ?></a></li>
    </ul>
    <div id="studcoursetitle">
      <h3 id="res2"><?php echo $numemat?></h3>
    </div>
  <div id="contentleft">    
    <table>
      <thead>
        <tr>
          <th>Name</th>
          <th>Deadline</th>
          <th>Nota</th>
        </tr>
      </thead>
      <tbody>
	  <?php
		$result = mysql_query("SELECT A.t as titlu, A.p as path, A.d as due, B.n as nota FROM (select assignment.IdAssignment as id, assignment.titlu as t,assignment.path as p,assignment.duedate as d
from assignment JOIN materie ON materie.IdMaterie=assignment.IdMaterie 
where materie.nume='$numemat') AS A
LEFT JOIN
 (select assignment.IdAssignment as id, nota.Nota as n from assignment
JOIN materie ON materie.IdMaterie=assignment.IdMaterie
JOIN submission ON submission.IdAssignment = assignment.IdAssignment
Join nota on submission.IdSubmission = nota.IdSubmission
join student on submission.IdStudent = student.IdStudent
join account on student.IdAccount = account.IdAccount
where materie.nume='$numemat'
and account.Username = '$username') AS B
ON A.id = B.id
ORDER BY due;");
		while($line = mysql_fetch_array($result, MYSQL_ASSOC)) {
	  ?>
		<tr>
          <td><a href="<?php print $line["path"]?>"><strong><?php print $line["titlu"]?></strong></a></td>
          <td><?php print $line["due"]?></td>
          <td><?php print $line["nota"]?></td>
        </tr>
    <?php }?>
    
      </tbody>
    </table>
	<form action="getfile.php" method="post" enctype='multipart/form-data'><br>
		<input type="file" name="uploadFile">
		<input type="submit"  name="submit" value="Upload File">
	</form>
	
  </div>
  <div id="contentright">
    <h3 id="res">Resources</h3>
    <ul id="resources">
	<?php
		$result = mysql_query("select resource.nume as n,resource.path as p 
			from resource JOIN materie ON materie.IdMaterie=resource.IdMaterie 
			where materie.nume='$numemat';");
		while($line = mysql_fetch_array($result, MYSQL_ASSOC)) {
	?>
		<li><a href="<?php print $line["p"]?>"><?php print $line["n"]?></a></li>
    <?php }?>
    </ul>  
  </div>
</div>
