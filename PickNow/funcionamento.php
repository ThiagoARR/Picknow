<?php
	require_once("config.php");

	$cnpj = $_POST["cnpj"];

	$usuario = new clsRestaurante();
	$usuario->setCd_cnpj_restaurante($cnpj);
	$restProx = $usuario->dia_funcionamento();
	echo $restProx;
?>