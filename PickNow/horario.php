<?php
	require_once("config.php");

	$cnpj = $_POST["cnpj"];
	$value = $_POST["value"];

	$usuario = new clsRestaurante();
	$usuario->setCd_cnpj_restaurante($cnpj);
	$usuario->setdiasemana($value);
	$restProx = $usuario->hora_funcionamento();
	echo $restProx;
?>