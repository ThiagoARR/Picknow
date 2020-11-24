<?php
	require_once("config.php");

	$usuario = new clsRestaurante();
	$restProx = $usuario->listarRestauranteItalianaNoGps();
	echo $restProx;
?>