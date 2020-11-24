<?php 

class clsBanco {

  private $servidor;
  private $usuario;
  private $senha;
  private $schema;
  
  public function getServidor(){
    return $this->servidor;
  }

  public function setServidor($servidor){
    $this->servidor = $servidor;
  }

  public function getUsuario(){
    return $this->usuario;
  }

  public function setUsuario($usuario){
    $this->usuario = $usuario;
  }

  public function getSenha(){
    return $this->senha;
  }

  public function setSenha($senha){
    $this->senha = $senha;
  }

  public function getSchema(){
    return $this->schema;
  }

  public function setSchema($schema){
    $this->schema = $schema;
  }


  public function __construct($s="localhost", $u="root", $p="root", $db="pickno16_pckDB")
  {
    $this->setServidor($s);
    $this->setUsuario($u);
    $this->setSenha($p);
    $this->setSchema($db);
  }

  public function abrir(&$conexao)
  {

    $conexao = new mysqli($this->getServidor(),$this->getUsuario(),$this->getSenha(),$this->getSchema());
  
    if ($conexao->connect_error):
    
      echo "Erro ao tentar se concetar no banco, arrume o código adm".$mysqli->mysql_error;
      return false;
    
    else:
    
      return true;

    endif;

  }

  public function fechar(&$conexao)
  {
    if (isset($conexao)): 
     $conexao->close(); 

    endif;
  }


  public function consultar($comando, &$dados)
  {
    if (clsBanco::abrir($conexao)):
    
        try
        {
            $dados = $conexao->query($comando);
            clsBanco::fechar($conexao);
            return true;
        }
        catch (Exception $e) 
        {
            return false;
        }
          
    else:
    
        return false;

    endif;

  }

  public function executar($comando)
  {
    if (clsBanco::abrir($conexao)):
    
        try
        {
            if ( $conexao->query($comando) === true ):
            
              clsBanco::fechar($conexao);  
              return true;
            
            else:
            
              clsBanco::fechar($conexao);  
              return false;

            endif;

        }
        catch (Exception $e) 
        {

          return false;

        }
    
    else:
    
        return false;

    endif;
 

} 

}

?>