<?php 

	require_once("config.php");

	$latitude = $_POST["latitude"];
	$longitude = $_POST["longitude"];

	$usuario = new clsRestaurante();
	$usuario->setlatitude($latitude);
	$usuario->setlongitude($longitude);
	echo $usuario->mapaRest();
?>
