<?php
require("reporting/fpdf.php");
$pdf = new FPDF( );
$pdf->AddPage();
$pdf->SetFont('Arial','B',16);
$pdf->Cell(10,10,'PHP - The Good Parts!', 0,0,'L');
$pdf->SetX(90);
$pdf->Cell(90,10,'Beware the Ides of March!', 1,0,'C');
$pdf->Output();
?>