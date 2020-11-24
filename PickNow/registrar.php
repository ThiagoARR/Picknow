<?php
	require_once("config.php");

	$nome = $_POST["nome"];
	$email = $_POST["email"];
	$senha = $_POST["senha"];
	$cpf = $_POST["cpf"];

	$usuario = new clsCliente();
	$usuario->setCd_cpf_cliente($cpf);
	$usuario->setNm_cliente($nome);
	$usuario->setNm_email_cliente($email);
	$usuario->setCd_senha_cliente($senha);

	if ( $usuario->cadastrarCliente())
	{
		Header("Location:login.php?success=1");
	}
	else
	{	
		header("Location:cadastro.php?erro=1");
	}

?>