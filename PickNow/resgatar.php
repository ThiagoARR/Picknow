<?php 

	require_once("config.php");
	$codigo = $_POST["codigo"];

	$usuario = new clsCodigo();
	$usuario->setCd_codigo_pontos($codigo);
    
	if ( $usuario->resgatarCodigo())
	{
        if ($usuario->codigoUsado()) 
        {
		  Header("Location:resgatarCodigo.php?validar=1");
        }
        else
        {
          Header("Location:resgatarCodigo.php?validar=2");
        }

	}
	else
	{	
		Header("Location:resgatarCodigo.php?validar=2");
	}

?>
