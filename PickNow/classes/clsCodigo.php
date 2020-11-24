<?php
  $somar;
  class clsCodigo extends clsBanco {

  private $vl_compra;
  private $vl_ponto;
  private $cd_cnpj_restaurante;
  private $cd_cpf_cliente;
  private $cd_codigo_pontos;
  private $nm_intervalo;

  public function getVl_compra(){
    return $this->vl_compra;
  }

  public function setVl_compra($vl_compra){
    $this->vl_compra = $vl_compra;
  }

  public function getVl_ponto(){
    return $this->vl_ponto;
  }

  public function setVl_ponto($vl_ponto){
    $this->vl_ponto = $vl_ponto;
  }

  public function getCd_cnpj_restaurante(){
    return $this->cd_cnpj_restaurante;
  }

  public function setCd_cnpj_restaurante($cd_cnpj_restaurante){
    $this->cd_cnpj_restaurante = $cd_cnpj_restaurante;
  }

  public function getCd_cpf_cliente(){
    return $this->cd_cpf_cliente;
  }

  public function setCd_cpf_cliente($cd_cpf_cliente){
    $this->cd_cpf_cliente = $cd_cpf_cliente;
  }

  public function getCd_codigo_pontos(){
    return $this->cd_codigo_pontos;
  }

  public function setCd_codigo_pontos($cd_codigo_pontos){
    $this->cd_codigo_pontos = $cd_codigo_pontos;
  }

  public function getNm_intervalo(){
    return $this->nm_intervalo;
  }

  public function setNm_intervalo($nm_intervalo){
    $this->nm_intervalo = $nm_intervalo;
  }

 public function cadastrarCodigo()
  {
     $comando = "select Sum('".$this->getVl_compra()."' + qt_pontos) as soma ";
     $comando .= "from cliente ";
     $comando .= "where cliente.cd_cpf_cliente = '".$this->getCd_cpf_cliente()."' ";
      if (clsCodigo::consultar($comando, $dados) === true)
            {
              while ($linha = $dados->fetch_array()) 
              {
                $comando2 = "update cliente set qt_pontos = '".$linha['soma']."' where cd_cpf_cliente = '".$this->getCd_cpf_cliente()."'";
                if (clsCodigo::executar($comando2))
                  {
                    $comando3 = "insert into lugares_visitados (cd_cpf_cliente,cd_cnpj_restaurante,dt_visita, vl_compra, vl_ponto) values ('".$this->getCd_cpf_cliente()."','".$this->getCd_cnpj_restaurante()."',NOW(),'".$this->getVl_compra()."','".$this->getVl_ponto()."')";
                    if (clsCodigo::executar($comando3))
                      {
                        return true;
                      }
                      else
                      {
                        return false;
                      }
                  }
                  else
                  {
                    return false;
                  }
              }
            }
      else
          {
            return false;
          }
  }

  public function listarCupom()
  {
    $comando = "select count(*) from cupom ";
    $comando .= "join restaurante ";
    $comando .= "join recompensas ";
    $comando .= "where cupom.cd_cpf_cliente = '".$_SESSION["login"]."' ";
    $comando .= "and cupom.cd_cnpj_restaurante = restaurante.cd_cnpj_restaurante ";
    $comando .= "and cupom.cd_cnpj_restaurante = recompensas.cd_cnpj_restaurante ";
    $comando .= "and cupom.cd_recompensa = recompensas.cd_recompensa ";
    $comando .= "and cupom.cd_situacao = 0 ";
    $comando .= "order by dt_resgate desc";
    if (clsCodigo::consultar($comando, $dados) === true)
    {
      while ($linha = $dados->fetch_array()) 
      {
        if ($linha[0] > 0) 
        {
          $comando2 = "select * from cupom ";
          $comando2 .= "join restaurante ";
          $comando2 .= "join recompensas ";
          $comando2 .= "where cupom.cd_cpf_cliente = '".$_SESSION["login"]."' ";
          $comando2 .= "and cupom.cd_cnpj_restaurante = restaurante.cd_cnpj_restaurante ";
          $comando2 .= "and cupom.cd_cnpj_restaurante = recompensas.cd_cnpj_restaurante ";
          $comando2 .= "and cupom.cd_recompensa = recompensas.cd_recompensa ";
          $comando2 .= "and cupom.cd_situacao = 0 ";
          $comando2 .= "order by dt_resgate desc";
          if (clsCodigo::consultar($comando2, $dados) === true)
           {
            while ($linha = $dados->fetch_array()) 
              {
                $validade = date('d/m/Y',strtotime($linha['dt_validade']));
                $hoje = new DateTime();
                if ($validade == $hoje->format('d/m/Y')) 
                {
                  $comando3 = "insert into cupom_usado values('".$linha['cd_cpf_cliente']."','".$linha['cd_cupom']."','".$linha['cd_cnpj_restaurante']."',null)";
                  if (clsCodigo::executar($comando3))
                      {
                        $comando4 = "update cupom set cd_situacao = 1 where cd_cupom = '".$linha['cd_cupom']."' ";
                        if (clsCodigo::executar($comando4))
                        {
                          return true;
                        }
                        else
                        {
                          return false;
                        }
                      }
                  else
                      {
                        return false;
                      }
                }
                else
                {
                  echo "<div class='boxwrapcupom'>";
                  echo "<div class='wrapcupom'>";
                  echo "<div class='date'>";
                  echo "<p>".date('d/m',strtotime($linha["dt_resgate"]))."</p>";
                  echo "</div>";
                  echo "<div class='nameplace'>";
                  echo "<p><b>".$linha['nm_restaurante']."</b></p>";
                  echo "<p class='desccupom'>".$linha['nm_recompensa']."</p>";
                  echo "<p class='validade'>Este cupom é válido até ".date('d/m/Y',strtotime($linha['dt_validade']))."</p>";
                  echo "</div>";
                  echo "<div class='cod'>";
                  echo "<p class='ocult b".$linha['cd_cupom']."'></p>";
                  echo "<p class='cup a".$linha['cd_cupom']."'>".$linha['cd_cupom']."</p>";
                  echo "</div>";
                  echo "<div class='eye'>";
                  echo "<i class='far fa-eye ".$linha['cd_cupom']."'></i>";
                  echo "</div>";
                  echo "</div>";
                  echo "</div>";
                }
              }
            }
            else
            {
              return false;
            }
          }
        else
          {
           echo "<div class='errormsg'>Você não possui Cupom.</div>";
          }
      }
    }
}

  public function listarJs()
  {
    $comando = "select * from cupom ";
    $comando .= "join restaurante ";
    $comando .= "where cupom.cd_cpf_cliente = '".$_SESSION["login"]."' ";
    $comando .= "and cupom.cd_cnpj_restaurante = restaurante.cd_cnpj_restaurante ";
    if (clsCodigo::consultar($comando, $dados) === true)
    {
      while ($linha = $dados->fetch_array()) 
      {
      echo "<script type='text/javascript'>";
      echo "$(document).ready(function() {";
      echo "$('.".$linha['cd_cupom']."').click(function() {";
      echo "$(this).toggleClass('fas fa-eye-slash');";
      echo "$('.b".$linha['cd_cupom']."').toggle();";
      echo "$('.a".$linha['cd_cupom']."').toggle();";
      echo "});";
      echo "});";
      echo "</script>";
      }
    }
  }


  public function resgatarCodigo()
    {
   
    }
}
  
  ?>