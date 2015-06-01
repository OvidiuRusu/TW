<?php
session_start();
include('connection.php');
require("reporting/fpdf.php");
class PDF extends FPDF
{
	function CreateTable($header,$materie)
	 {
	 	// Column widths
    $w = array(53, 30);
    // Header
    for($i=0;$i<count($header);$i++)
        $this->Cell($w[$i],7,$header[$i],1,0,'C');
    $this->Ln();
    // Data

    $result = mysql_query("select student.IdStudent as idstud, student.Nume as n, student.Prenume as p from student
			left join student_materie on student.IdStudent=student_materie.IdStudent
			left join materie on student_materie.IdMaterie = materie.IdMaterie
			where student_materie.Status='In Curs'
			and materie.Nume='$materie'");
    while($line = mysql_fetch_array($result, MYSQL_ASSOC)) {
        $this->Cell($w[0],6,$line["n"]." ".$line["p"],'LR');
		$idstud = $line["idstud"];
		$result2 = mysql_query("select assignment.IdAssignment as idassign from assignment 
										join materie on materie.idMaterie=assignment.idMaterie 
										where materie.nume = '$materie'");
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
		$this->Cell($w[1],6,round($medie,2),'LR');
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