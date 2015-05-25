<!DOCTYPE html>
<?php 
  session_start();
  if (!isset($_SESSION['username']) || empty($_SESSION['username'])) {
    exit();
  }
  $username = $_SESSION['username'];
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
    <ul id="nav2">
      <li><a href="#" style="color: #000;">Active Courses</a></li>
      <li><a href="#">Catalog</a></li>
      <li><a href="#">Course List</a></li>
    </ul>
    <div class="coursebox">
      <h3><a href="#">SGBD</a><h3>
      <h4>Facultatea de Informatica</h4>
      <h4>Started: 15 feb 2015<h4> 
    </div>
    <div class="coursebox">
      <h3><a href="#">Programare Avansata</a><h3>
      <h4>Facultatea de Informatica</h4>
      <h4>Started: 15 feb 2015<h4> 
    </div>
    <div class="coursebox">
      <h3><a href="#">Ingineria Programarii</a><h3>
      <h4>Facultatea de Informatica</h4>
      <h4>Started: 15 feb 2015<h4> 
    </div>
    <div class="coursebox">
      <h3><a href="#">Programare Logica</a><h3>
      <h4>Facultatea de Informatica</h4>
      <h4>Started: 15 feb 2015<h4> 
    </div>
  </div>
  <div id="contentright">
    <h2>Assignments Deadlines</h2>
    <table>
      <thead>
        <tr>
          <th>Name</th>
          <th>Due Date</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td><strong>SGBD_Tema8</strong></td>
          <td>25 apr 2015</td>
        </tr>
        <tr>
          <td><strong>PA_Tema7</strong></td>
          <td>26 apr 2015</td>
        </tr>
        <tr>
          <td><strong>PL_Tema7</strong></td>
          <td>28 apr 2015</td>
        </tr>
      </tbody>
    </table>
  </div>
<!-- <div id="footer">
  <div id="bottomlinks">
  <a href="index.html">homepage</a> | <a href="mailto:tacutanu.vlad@gmail.com">contact</a> |  <a href="images/sitemap.png"> sitemap</a> | &copy; 2015 Mitocariu Emilian • Rusu Ovidiu • Stoian Sorin • Tacutanu Vlad
</div> -->
</div>
</body>
</html>
