<?php
session_start();
include('connection.php');
require("reporting/fpdf.php");
class PDF extends FPDF
{
	function CreateTableMedii($header,$materie){
		// Column widths
		$w = array(53, 30);
		// Header
		for($i=0;$i<count($header);$i++)
			$this->Cell($w[$i],7,$header[$i],1,0,'C');
		$this->Ln();

		$result = mysql_query("select student.IdStudent as idstud, student.Nume as n, student.Prenume as p from student
				left join student_materie on student.IdStudent=student_materie.IdStudent
				left join materie on student_materie.IdMaterie = materie.IdMaterie
				where student_materie.Status='In Curs'
				and materie.Nume='$materie'");
		$y=0;
		while($line = mysql_fetch_array($result, MYSQL_ASSOC)) {
			$y=$y+6;
			$this->SetXY(65,41+$y);
			$this->Cell($w[0],6,$line["n"]." ".$line["p"],1,0,'LR');
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
			$this->SetXY(118,41+$y);
			$this->Cell($w[1],6,round($medie,2),1,0,'C');
			$this->Ln();
		}
		
		// Closing line
		$y=$y+6;
		$this->SetXY(65,41+$y);
		$this->Cell(array_sum($w),0,'','T');
	}
	 
	function CreateTableNrsub($header,$materie){
		// Column widths
		$w = array(53, 30);
		// Header
		for($i=0;$i<count($header);$i++)
			$this->Cell($w[$i],7,$header[$i],1,0,'C');
		$this->Ln();

		$result = mysql_query("select student.IdStudent as idstud, student.Nume as n, student.Prenume as p from student
				left join student_materie on student.IdStudent=student_materie.IdStudent
				left join materie on student_materie.IdMaterie = materie.IdMaterie
				where student_materie.Status='In Curs'
				and materie.Nume='$materie'");
		$y=0;
		while($line = mysql_fetch_array($result, MYSQL_ASSOC)) {
			$y=$y+6;
			$this->SetXY(65,41+$y);
			$this->Cell($w[0],6,$line["n"]." ".$line["p"],1,0,'LR');
			$idstud = $line["idstud"];
			$result2=mysql_query("select count(submission.IdSubmission) as nr from submission
										join assignment on submission.IdAssignment=assignment.IdAssignment
										join materie on assignment.IdMaterie=materie.IdMaterie
										where submission.IdStudent=$idstud and materie.Nume='$materie'");
			$line2 = mysql_fetch_array($result2, MYSQL_ASSOC);
				$this->SetXY(118,41+$y);
				$this->Cell($w[1],6,$line2["nr"],1,0,'C');
				$this->Ln();
		}
		// Closing line
		$y=$y+6;
		$this->SetXY(65,41+$y);
		$this->Cell(array_sum($w),0,'','T');
	}
	
	function CreateTableMat($header){
		// Column widths
		$w = array(80, 45);
		// Header
		for($i=0;$i<count($header);$i++)
			$this->Cell($w[$i],7,$header[$i],1,0,'C');
		$this->Ln();
		
		$y=0;
		$result4=mysql_query("select nume from materie");
		while($line4 = mysql_fetch_array($result4, MYSQL_ASSOC)){
			$materie=$line4["nume"];
			$nrstud=0;
			$mediemat=0;
			$y=$y+6;
			$this->SetXY(40,41+$y);
			$this->Cell($w[0],6,$materie,1,0,'LR');
			$result = mysql_query("select student.IdStudent as idstud, student.Nume as n, student.Prenume as p from student
					left join student_materie on student.IdStudent=student_materie.IdStudent
					left join materie on student_materie.IdMaterie = materie.IdMaterie
					where student_materie.Status='In Curs'
					and materie.Nume='$materie'");
			while($line = mysql_fetch_array($result, MYSQL_ASSOC)) {
				$nrstud=$nrstud+1;
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
				if($nr>0){
					$mediemat=$mediemat+$medie/$nr;
				}
			}
			if($nrstud==0){
				$mediemat=0;
			}else{
				$mediemat=$mediemat/$nrstud;
			}
			$this->SetXY(120,41+$y);
			$this->Cell($w[1],6,round($mediemat,2),1,0,'C');
			$this->Ln();
		}
		
		// Closing line
		$y=$y+6;
		$this->SetXY(40,41+$y);
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
$pdf->SetXY(65,40);
$pdf->CreateTableMedii($header,$mat);

$header = array('Nume Student', 'Nr. Teme');
$pdf->AddPage();
$pdf->SetXY(100,10);
$pdf->Cell(10,10,''.$mat, 0,0,'C');
$pdf->Cell(3,30,'Nr. de rezolvari trimise', 0,0,'C');
$pdf->SetXY(65,40);
$pdf->CreateTableNrsub($header,$mat);

$header = array('Materie', 'Medie Studenti');
$pdf->AddPage();
$pdf->SetXY(100,10);
$pdf->Cell(10,10,''.$mat, 0,0,'C');
$pdf->Cell(3,30,'Statistici profesori', 0,0,'C');
$pdf->SetXY(40,40);
$pdf->CreateTableMat($header);

$pdf->Output();
?>