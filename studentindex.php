<!DOCTYPE html>
<?php 
  session_start();
  include('connection.php');
  if (!isset($_SESSION['username']) || empty($_SESSION['username'])) {
    exit();
  }
  $username = $_SESSION['username'];  

require('mysql_table.php');
class PDF extends PDF_MySQL_Table
{
function Header()
{
	//Title
	$this->SetFont('Arial','',18);
	$this->Cell(0,6,'PDF From mysql',0,1,'C');
	$this->Ln(10);
	//Ensure table header is output
	parent::Header();
}
}


$pdf=new PDF();
$pdf->AddPage();
//First table: put all columns automatically
$pdf->Table('SELECT * from nota');
$pdf->AddPage();
if(isset($_POST['ExportToPDF'])) {
$variabila=$_POST['ExportToPDF'];


$pdf->Output("fisier".".pdf"); 
///header('Location: '."fisier".".pdf",_blank);


}
?>



<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Student Index</title>
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
      <li><a href="#"><?php echo $username ?></a></li>
    </ul>
  <div id="contentleft">
    <ul id="nav2" style="margin-left: 40px">
      <li><a href="studentindex.php" style="color: #000;">Active Courses</a></li>
      <li><a href="studentcourselist.php">Course List</a></li>
    </ul>
    <?php
    $result = mysql_query("SELECT materie.Nume AS n, student_materie.StartDate AS d FROM materie JOIN student_materie ON materie.IdMaterie=student_materie.IdMaterie
 JOIN student ON student_materie.IdStudent=student.IdStudent
 JOIN account ON student.IdAccount=account.IdAccount
 WHERE account.Username = '$username' AND student_materie.Status='In Curs'");
    while($line = mysql_fetch_array($result, MYSQL_ASSOC)) {
      echo '<div class="coursebox">
      <h3><a href="studentcourse.php?name=',$line["n"],'">',$line["n"],'</a><h3>
      <h4>Facultatea de Informatica</h4>
      <h4>Started: ' ,$line["d"],'<h4> 
    </div>';
    }
    ?>
  </div>
  <div id="contentright">
    <h2>Assignments Deadlines</h2>
    <table>
      <thead>
        <tr>
          <th>Course</th>
          <th>Name</th>
          <th>Due Date</th>
        </tr>
      </thead>
      <tbody>
        <?php
    $result = mysql_query("SELECT assignment.Titlu AS titlu, assignment.DueDate AS due, assignment.Path AS path, materie.Nume AS name 
      FROM assignment JOIN materie ON assignment.IdMaterie = materie.IdMaterie WHERE assignment.DueDate < '2015-03-19';");
    while($line = mysql_fetch_array($result, MYSQL_ASSOC)) {
    echo '<tr>
          <td>',$line["name"],'</td>
          <td><a href="',$line["path"],'"><strong>',$line["titlu"],'</strong></a></td>
          <td>',$line["due"],'</td>
        </tr>';
         }
         ?>
      </tbody>
    </table>
  </div>
<!-- <div id="footer">
  <div id="bottomlinks">
  <a href="index.html">homepage</a> | <a href="mailto:tacutanu.vlad@gmail.com">contact</a> |  <a href="images/sitemap.png"> sitemap</a> | &copy; 2015 Mitocariu Emilian • Rusu Ovidiu • Stoian Sorin • Tacutanu Vlad
</div> -->
</div>
  <form method="POST" name="simpleUsing" action="http://localhost/TW/fisier.pdf" target="_BLANK">

	<input method="POST" type="submit" name="ExportToPDF" value="Export to PDF">
	
</form>
</body>
</html>