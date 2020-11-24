<?php
  
  class clsCliente extends clsBanco {

  private $cd_cpf_cliente;
  private $cd_senha_cliente;
  private $nm_cliente;
  private $qt_pontos;
  private $nm_login_cliente;
  private $nm_email_cliente;

  public function getCd_cpf_cliente(){
    return $this->cd_cpf_cliente;
  }

  public function setCd_cpf_cliente($cd_cpf_cliente){
    $this->cd_cpf_cliente = $cd_cpf_cliente;
  }

  public function getCd_senha_cliente(){
    return $this->cd_senha_cliente;
  }

  public function setCd_senha_cliente($cd_senha_cliente){
    $this->cd_senha_cliente = $cd_senha_cliente;
  }

  public function getNm_cliente(){
    return $this->nm_cliente;
  }

  public function setNm_cliente($nm_cliente){
    $this->nm_cliente = $nm_cliente;
  }

  public function getQt_pontos(){
    return $this->qt_pontos;
  }

  public function setQt_pontos($qt_pontos){
    $this->qt_pontos = $qt_pontos;
  }

  public function getNm_login_cliente(){
    return $this->nm_login_cliente;
  }

  public function setNm_login_cliente($nm_login_cliente){
    $this->nm_login_cliente = $nm_login_cliente;
  }

  public function getNm_email_cliente(){
    return $this->nm_email_cliente;
  }

  public function setNm_email_cliente($nm_email_cliente){
    $this->nm_email_cliente = $nm_email_cliente;
  }

    public function carregarUsuario()
  {
      $comando = "SELECT * from cliente where cd_cpf_cliente = '".$this->getCd_cpf_cliente()."'";
      $comando .= " and cd_senha_cliente = md5('".$this->getCd_senha_cliente()."')";
      if (clsCliente::consultar($comando, $dados) === true)
      {
        if ( $linha = $dados->fetch_array() ) 
        {
          if (isset($linha))
          {
            return true;
          }
          else
          {
            return false;
          }
        }        
      }
      return false;
  }

  public function infoCliente()
  {
    $comando =  "select * ";
    $comando .= "from cliente ";
    $comando .= "where cd_cpf_cliente = '".$_SESSION["login"]."' ";
    if (clsCliente::consultar($comando, $dados) === true)
    {
      while ($linha = $dados->fetch_array()) 
      {
        echo "<p class='username'>".$linha['nm_cliente']."</p>";
        echo "<p class='email'>".$linha['nm_email_cliente']."</p>";
      }
    }
  }

  public function infoCliente2()
  {
    $comando =  "select * ";
    $comando .= "from cliente ";
    $comando .= "where cd_cpf_cliente = '".$_SESSION["login"]."' ";
    if (clsCliente::consultar($comando, $dados) === true)
    {
      while ($linha = $dados->fetch_array()) 
      {
        echo "<p class='nm'>".$linha['nm_cliente']."</p>";
        echo "<p class='em'>".$linha['nm_email_cliente']."</p>";
      }
    }
  }

  public function imgMenuCliente()
  {
    $comando =  "select * ";
    $comando .= "from cliente ";
    $comando .= "where cd_cpf_cliente = '".$_SESSION["login"]."' ";
    if (clsCliente::consultar($comando, $dados) === true)
    {
      while ($linha = $dados->fetch_array()) 
      {
        echo "<img src='".$linha['cd_img_cliente']."' width='100px' height='100px'>";
      }
    }
  }

  public function listarTrocas()
  {
    $comando = "select count(*) as total from trocas_efetuadas where cd_cpf_cliente = '".$_SESSION["login"]."' ";
    if (clsCliente::consultar($comando, $dados) === true)
    {
      while ($linha = $dados->fetch_array()) 
      {
        echo "<div class='wrapvisitados'><i class='fas fa-wallet'></i><p class='sectionVisitados'>Trocas Efetuadas</p><p class='qtdVisit'>".$linha['total']."</p></div>";
      }
    }
  }

  public function imgIndexCliente()
  {
    $comando =  "select * ";
    $comando .= "from cliente ";
    $comando .= "where cd_cpf_cliente = '".$_SESSION["login"]."' ";
    if (clsCliente::consultar($comando, $dados) === true)
    {
      while ($linha = $dados->fetch_array()) 
      {
        if (is_null($linha['cd_img_cliente'])) 
        {
          echo "<img class='imgperf border' src='download.png' width='160px' height='160px'>";
        }
        else
        {
          echo "<img class='imgperf' src='".$linha['cd_img_cliente']."' width='160px' height='160px'>";
        }
      }
    }
  }

  public function infoBar()
  {
    $comando = "select * from cliente where cd_cpf_cliente = '".$_SESSION["login"]."' ";
    if (clsCliente::consultar($comando, $dados)) 
      {
        while ($linha = $dados->fetch_array()) 
        {
          if (is_null($linha["cd_img_cliente"])) 
          {
            echo "<div class='wrapinfobar'><div class='wrappicnm'><div class='piclogin'><img src=''></div><p class='nmlogin'>".$linha['nm_cliente']."</p></div><div class='wrappicnm'><i class='fas fa-wallet'></i><p class='local'>".$linha['qt_pontos']." <span>pts</span></p></div></div>";
          }
          else
          {
          echo "<div class='wrapinfobar'><div class='wrappicnm'><div class='piclogin'><img src=".$linha['cd_img_cliente']." class='piclogin'></div><p class='nmlogin'>".$linha['nm_cliente']."</p></div><div class='wrappicnm'><i class='fas fa-wallet'></i><p class='local'>".$linha['qt_pontos']." <span>pts</span></p></div></div>";
          }
        }      
      }
  }

  public function cadastrarCliente()
  {
    $comando = "Select count(*) from cliente where cd_cpf_cliente ='".$this->getCd_cpf_cliente()."' ";
    if (clsCliente::consultar($comando, $dados) === true)
    {
      while ($linha = $dados->fetch_array()) 
      {
        if ($linha[0] > 0) 
        {
          return false;
        }
        else
        {
          $comando2 = "Select count(*) from cliente where nm_email_cliente ='".$this->getNm_email_cliente()."' ";
          if (clsCliente::consultar($comando2, $dados) === true)
          {
            while ($linha = $dados->fetch_array()) 
            {
              if ($linha[0] > 0) 
              {
                return false;
              }
              else
              {
              $comando3 = "insert into cliente values ('".$this->getCd_cpf_cliente()."','".$this->getNm_cliente()."',md5('". $this->getCd_senha_cliente() ."'),'".$this->getNm_email_cliente()."',null,0) ";
                if (clsCliente::executar($comando3))
                 {
                  return true;
                 }
                else
                 {
                  return false;
                 }
             }
          }
        }
      }
    }
  }
}


 public function nmCliente()
  {
    $comando =  "select * ";
    $comando .= "from cliente ";
    $comando .= "where cd_cpf_cliente = '".$_SESSION["login"]."' ";
    if (clsCliente::consultar($comando, $dados) === true)
    {
      while ($linha = $dados->fetch_array()) 
      {
        echo "<input type='text' name='login' value='".$linha['nm_cliente']."' readonly><br>";
      }
    }
  }

  public function emailCliente()
  {
    $comando =  "select * ";
    $comando .= "from cliente ";
    $comando .= "where cd_cpf_cliente = '".$_SESSION["login"]."' ";
    if (clsCliente::consultar($comando, $dados) === true)
    {
      while ($linha = $dados->fetch_array()) 
      {
        echo "<input type='email' name='email' value='".$linha['nm_email_cliente']."' readonly><br>";
      }
    }
  }

  public function pontoCliente()
  {
    $comando =  "select * ";
    $comando .= "from cliente ";
    $comando .= "where cd_cpf_cliente = '".$_SESSION["login"]."' ";
    if (clsCliente::consultar($comando, $dados) === true)
    {
      while ($linha = $dados->fetch_array()) 
      {
        echo "<p class='qtd'>".$linha['qt_pontos']."</p>";
      }
    }
  }
}
  ?>