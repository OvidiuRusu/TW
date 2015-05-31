 <!DOCTYPE html>
 <?php 
  session_start();
  include('connection.php');
  if (!isset($_SESSION['username']) || empty($_SESSION['username'])) {
    exit();
  }
  $username = $_SESSION['username'];  
?>
<head>
  <link href="table.css" rel="stylesheet" type="text/css" />
  <title>Catalog</title>
 </head>
 <body> 
 <table>
    <thead>
      <tr>
        <th>Student Name</th>
        <th>Tema1</th>
        <th>Proiect</th>
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
          <td width = 70px;>',$line["due"],'</td>
        </tr>';
         }
         ?>
    </tbody>
  </table>
</body>  
</html>  