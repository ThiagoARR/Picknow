 <?php 
   require_once('config.php');
  
  $login = $_POST['login'];
  $senha = $_POST['senha'];
  
  $usuario = new clsCliente();
  $usuario->setCd_cpf_cliente($login);
  $usuario->setCd_senha_cliente($senha);

  if ( $usuario->carregarUsuario() === true)
    {
     $_SESSION["login"] = $_POST["login"];
        Header("Location:index.php");
    }
    else
    {
    	Header("Location:login.php");
    }
?>