<?php 

	require_once("config.php");
	$codigo = $_POST['id'];

	$usuario = new clsRestaurante();
	$usuario->setCd_cnpj_restaurante($codigo);
    $usuario->desfavoritar();
?>
