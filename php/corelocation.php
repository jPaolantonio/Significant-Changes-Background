<?php
	$id_1 = $_GET['latitude'];
	$id_2 = $_GET['longitude'];
	$id_3 = $_GET['background'];
	$id_4 = $_GET['other'];

	$myFile = "latFile.txt";
	$fh = fopen($myFile, 'a') or die("can't open file");

	fwrite($fh, $id_1);
	$stringData = "\n";
	fwrite($fh, $stringData);

	fwrite($fh, $id_2);
	$stringData = "\n";
	fwrite($fh, $stringData);

	fwrite($fh, $id_3);
	$stringData = "\n";
	fwrite($fh, $stringData);

	fwrite($fh, $id_4);
	$stringData = "\n\n\n";
	fwrite($fh, $stringData);

	fwrite($fh, $stringData);
	fclose($fh);
?>