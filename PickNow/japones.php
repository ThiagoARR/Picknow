<?php
	require_once("config.php");

	$lat = $_POST["lat"];
	$lng = $_POST["lng"];

	$usuario = new clsRestaurante();
	$usuario->setlatitude($lat);
	$usuario->setlongitude($lng);
	$restProx = $usuario->listarRestauranteJapones();
	echo $restProx;
?>