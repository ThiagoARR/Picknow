<?php 

	require_once("config.php");

	$pesquisa = $_POST["search"];

	$usuario = new clsRestaurante();
	$usuario->setpesquisa($pesquisa);
	$pesq = $usuario->listarPesquisa();
	echo $pesq;
?>
