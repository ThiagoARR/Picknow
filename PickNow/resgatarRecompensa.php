<?php 

	require_once("config.php");
	$tamanho = 5;
    $lmai = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    $num = '1234567890';
    // Variáveis internas
    $retorno = '';
    $caracteres = '';
    // Agrupamos todos os caracteres que poderão ser utilizados
    $caracteres .= $lmai;
	$caracteres .= $num;
    // Calculamos o total de caracteres possíveis
    $len = strlen($caracteres);
    for ($n = 1; $n <= $tamanho; $n++) {
    // Criamos um número aleatório de 1 até $len para pegar um dos caracteres
    $rand = mt_rand(1, $len);
    // Concatenamos um dos caracteres na variável $retorno
    $retorno .= $caracteres[$rand-1];
	}

	$codigo = $_GET["codigo"];
	$cupom = $retorno;
	$cnpj = $_GET["recompensas"];
	$usuario = new clsRestaurante();
	$usuario->setCd_recompensa($codigo);
	$usuario->setCd_cupom($cupom);
	$usuario->setCd_cnpj_restaurante($cnpj);
	

	if ( $usuario->trocarPonto())
	{
		Header("Location:recompensas.php?recompensas=".$cnpj."&validar=1");
	}
	else
	{	
		header("Location:recompensas.php?recompensas=".$cnpj."&validar=2");
	}

?>