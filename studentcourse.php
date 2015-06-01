<!DOCTYPE html>
<?php 
  session_start();
  include('connection.php');
  if (!isset($_SESSION['username']) || empty($_SESSION['username'])) {
    exit();
  }
  $username = $_SESSION['username'];
  $numemat=$_GET["name"];
  $_SESSION['numemat']=$numemat;
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
		$result = mysql_query("SELECT A.t as titlu, A.p as path, A.d as due, B.n as nota, A.type as tip FROM (select assignment.IdAssignment as id,
    assignment.titlu as t,assignment.path as p,assignment.duedate as d, assignment.tip as type
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
		    if($line["tip"]=='Tema'){
				echo '<tr>
				  <td><a href="',$line["path"],'"><strong>',$line["titlu"],'</strong></a></td>
				  <td>',$line["due"],'</td>
				  <td>',$line["nota"],'</td>
				</tr>';
			}
			else{
				$result1=mysql_query("select student.IdStudent as idstud from account
											join student on account.IdAccount=student.IdAccount
											where account.Username='emilian.mitocariu'");
				$line1=mysql_fetch_array($result1, MYSQL_ASSOC);
				$idstud=$line1["idstud"];
				$result2 = mysql_query("select assignment.IdAssignment as idassign from assignment 
											join materie on materie.idMaterie=assignment.idMaterie 
											where materie.nume = '$numemat'");
				$medie=0;
				$nr=0;
				while($line2 = mysql_fetch_array($result2, MYSQL_ASSOC)){
						$idassign = $line2["idassign"];
						$result3 = mysql_query("select nota.Nota as nota from nota
													join submission on submission.IdSubmission=nota.IdSubmission
													join assignment on assignment.IdAssignment=submission.IdAssignment
													where assignment.IdAssignment=$idassign and submission.IdStudent=$idstud");
						$line3 = mysql_fetch_array($result3, MYSQL_ASSOC);
						if(is_null($line3["nota"])){
							$nr=$nr+1;
						}else{
							$nr=$nr+1;
							$medie=$medie+$line3["nota"];
						}
				}
				$medie=$medie/$nr;
				if($medie>5){
					echo '<tr>
					  <td><a href="',$line["path"],'"><strong>',$line["titlu"],'</strong></a></td>
					  <td>',$line["due"],'</td>
					  <td>',$line["nota"],'</td>
					</tr>';
				}else{
					echo '<tr>
					  <td><a href="',$line["path"],'"><strong>',$line["titlu"],'</strong></a></td>
					  <td>',$line["due"],'</td>
					  <td style="color:#FF0000; text-align:center; font-weight:bold; font-size:17px;">X</td>
					</tr>';
				}
			}
       }
         ?>
    
      </tbody>
    </table>
	<form action="uploadstud.php" method="post" enctype='multipart/form-data' class="formular"><br>
		Numar Tema<input type="text" name="numetema"><br>
		<input type="file" name="uploadFile" class="file-upload">
		<input type="submit"  name="submit" value="Upload File" class="submit-upload">
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
