<?php
	require_once("config.php");

	$usuario = new clsRestaurante();
	$restProx = $usuario->listarRestauranteJaponesNoGps();
	echo $restProx;
?>