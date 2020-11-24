<?php 

	require_once("config.php");

	$cpf = $_POST["cpf"];
	$cnpj = $_POST["cnpj"];
	$valor = $_POST["indice"];

	$pontos = $valor / 100 * 30;


	$usuario = new clsCodigo();
	$usuario->setCd_cpf_cliente($cpf);
	$usuario->setCd_cnpj_restaurante($cnpj);
	$usuario->setVl_compra($pontos);
	$usuario->setVl_ponto($valor);

	if ( $usuario->cadastrarCodigo())
	{
		Header("Location:codigo.php");
	}
	else
	{	
		header("Location:ashdasd.php");
	}

?>
