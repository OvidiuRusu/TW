<?php
session_start();
include('connection.php');
require("reporting/fpdf.php");
class PDF extends FPDF
{
	function CreateTable($header, $data)
	 {
	 	// Column widths
    $w = array(40, 35, 40, 45);
    // Header
    for($i=0;$i<count($header);$i++)
        $this->Cell($w[$i],7,$header[$i],1,0,'C');
    $this->Ln();
    // Data
    foreach($data as $row)
    {
        $this->Cell($w[0],6,$row[0],'LR');
        $this->Cell($w[1],6,$row[1],'LR');
        $this->Ln();
    }
    // Closing line
    $this->Cell(array_sum($w),0,'','T');
	 }
}
$mat = $_SESSION['numemat'];
$header = array('Nume Student', 'Media');
$pdf = new PDF( );
$pdf->AddPage();
$pdf->SetXY(100,10);
$pdf->SetFont('Arial','B',16);
$pdf->Cell(10,10,''.$mat, 0,0,'C');
$pdf->Cell(3,30,'Media temelor pentru fiecare student', 0,0,'C');
$pdf->SetXY(10,40);
$pdf->CreateTable($header,$header);

$pdf->Output();

?>