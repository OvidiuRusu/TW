<?php

$continutpagina1 = file_get_contents('file1.txt');
$continutpagina2 = file_get_contents('file2.txt');

$variabila_text="Procentul de similaritate gasit intre continutul celor doua fisiere este: ";

similar_text($continutpagina1,$continutpagina2, $procent_similaritate);

echo "<p style='color:black; font-size: 200%; font-style: italic;'>".$variabila_text;

if ($procent_similaritate>90)
echo "<p style='color:DarkRed ; font-style: italic; font-weight: bold; font-size: 250%;'>".$procent_similaritate."%";

if ($procent_similaritate<=90 && $procent_similaritate>=70)
echo "<p style='color:Red; font-style: italic; font-weight: bold; font-size: 250%;'>".$procent_similaritate."%"; 

if ($procent_similaritate<70 && $procent_similaritate>=50)
echo "<p style='color:Coral; font-style: italic; font-weight: bold; font-size: 250%;'>".$procent_similaritate."%"; 

if ($procent_similaritate<50 && $procent_similaritate>=20)
echo "<p style='color:LightGreen ; font-style: italic; font-weight: bold; font-size: 250%;'>".$procent_similaritate."%"; 

if ($procent_similaritate<20 && $procent_similaritate>=10)
echo "<p style='color:YellowGreen; font-style: italic; font-weight: bold; font-size: 250%;'>".$procent_similaritate."%"; 

if ($procent_similaritate<10)
echo "<p style='color:green; font-style: italic; font-weight: bold; font-size: 250%;'>".$procent_similaritate."%";
?>
