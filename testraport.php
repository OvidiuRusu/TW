<?php
session_start();
include('connection.php');
require("reporting/fpdf.php");
class PDF extends FPDF
{
	function CreateTable($header,$materie)
	 {
	 	// Column widths
    $w = array(53, 35);
    // Header
    for($i=0;$i<count($header);$i++)
        $this->Cell($w[$i],7,$header[$i],1,0,'C');
    $this->Ln();
    // Data

    $nrstud = mysql_query("select student.IdStudent as id, student.Nume as n, student.Prenume as p from student
left join student_materie on student.IdStudent=student_materie.IdStudent
left join materie on student_materie.IdMaterie = materie.IdMaterie
where student_materie.Status='In Curs'
and materie.Nume='$materie'");
    while($line = mysql_fetch_array($nrstud, MYSQL_ASSOC)) {
        $this->Cell($w[0],6,$line["n"]." ".$line["p"],'LR');
        $this->Ln();
    }

    /*foreach($data as $row)
    {
        $this->Cell($w[0],6,$row[0],'LR');
        $this->Cell($w[1],6,$row[1],'LR');
       
    } */
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
$pdf->CreateTable($header,$mat);

$pdf->Output();

?>