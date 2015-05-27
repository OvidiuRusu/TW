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
      <li><a href="#" style="color: #000;">Assigments</a></li>
      <li><a href="profsubs.php?name=<?php print $numemat?>">Submissions</a></li>
      <li><a href="#">Catalog</a></li>
    </ul>  
    <table>
      <thead>
        <tr>
          <th>Name</th>
          <th>Deadline</th>
        </tr>
      </thead>
      <tbody>
	  <?php
		$result = mysql_query("select assignment.titlu as t,assignment.path as p,assignment.duedate as d
			from assignment JOIN materie ON materie.IdMaterie=assignment.IdMaterie 
			where materie.nume='$numemat';");
		while($line = mysql_fetch_array($result, MYSQL_ASSOC)) {
	  ?>
		<tr>
          <td><a href="<?php print $line["p"]?>"><strong><?php print $line["t"]?></strong></a></td>
          <td><?php print $line["d"]?></td>
        </tr>
    <?php }?>
      
      </tbody>
    </table>
    <label class="custom-file-upload">
      <input type="file"/>Add Assignment
    </label>
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
  <label class="resource-upload">
      <input type="file"/>Upload
  </label>
  </div>
</div>
</body>
</html>