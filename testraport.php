<?php
session_start();
include('connection.php');
require("reporting/fpdf.php");
$mat = $_SESSION['numemat'];
$pdf = new FPDF( );
$pdf->AddPage();
$pdf->SetXY(100,10);
$pdf->SetFont('Arial','B',16);
$pdf->Cell(10,10,''.$mat, 0,0,'C');
$pdf->Cell(3,30,'Media temelor pentru fiecare student', 0,0,'C');
$pdf->Output();

?>