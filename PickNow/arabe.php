<?php
	require_once("config.php");
if (isset($_POST["lat"])) 
{
	$lat = $_POST["lat"];
	$lng = $_POST["lng"];

	$usuario = new clsRestaurante();
	$usuario->setlatitude($lat);
	$usuario->setlongitude($lng);
	$restProx = $usuario->listarRestauranteArabe();
	echo $restProx;
}
else
{
	$usuario = new clsRestaurante();
	$restProx = $usuario->listarRestauranteArabeNoGps();
	echo $restProx;
}
?>