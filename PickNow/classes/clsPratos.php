<?php
  
  class clsPratos extends clsBanco {

  private $cd_cnpj_restaurante;
  private $nm_restaurante;
  private $cd_categoria;
  private $nm_categoria;
  private $cd_img_restaurante;
  private $cd_prato;
  private $cd_tipo_prato;
  private $nm_prato;
  private $ds_ingredientes_prato;
  private $vl_preco_prato;

  public function getCd_cnpj_restaurante(){
    return $this->cd_cnpj_restaurante;
  }

  public function setCd_cnpj_restaurante($cd_cnpj_restaurante){
    $this->cd_cnpj_restaurante = $cd_cnpj_restaurante;
  }

  public function getNm_restaurante(){
    return $this->nm_restaurante;
  }

  public function setNm_restaurante($nm_restaurante){
    $this->nm_restaurante = $nm_restaurante;
  }

  public function getCd_prato(){
    return $this->cd_prato;
  }

  public function setCd_prato($cd_prato){
    $this->cd_prato = $cd_prato;
  }

  public function getCd_categoria(){
    return $this->cd_categoria;
  }

  public function setCd_categoria($cd_categoria){
    $this->cd_categoria = $cd_categoria;
  }

  public function getCd_tipo_prato(){
    return $this->cd_tipo_prato;
  }

  public function setCd_tipo_prato($cd_tipo_prato){
    $this->cd_tipo_prato = $cd_tipo_prato;
  }

  public function getNm_prato(){
    return $this->nm_prato;
  }

  public function setNm_prato($nm_prato){
    $this->nm_prato = $nm_prato;
  }

  public function getDs_ingredientes_prato(){
    return $this->ds_ingredientes_prato;
  }

  public function setDs_ingredientes_prato($ds_ingredientes_prato){
    $this->ds_ingredientes_prato = $ds_ingredientes_prato;
  }

  public function getNm_categoria(){
    return $this->nm_categoria;
  }

  public function setNm_categoria($nm_categoria){
    $this->nm_categoria = $nm_categoria;
  }

  public function getVl_preco_prato(){
    return $this->vl_preco_prato;
  }

  public function setVl_preco_prato($vl_preco_prato){
    $this->vl_preco_prato = $vl_preco_prato;
  }

  public function imgRestaurante($cnpj="")
  {
    $comando =  "select * ";
    $comando .= "from restaurante ";
    $comando .= "join categoria ";
    $comando .= "where cd_cnpj_restaurante = '".$cnpj."'";
    $comando .= "and restaurante.cd_categoria = categoria.cd_categoria ";
    if (clsPratos::consultar($comando, $dados) === true)
    {
      while ($linha = $dados->fetch_array()) 
      {
       echo "<img class='imgrest' src='".$linha['cd_img_restaurante']."' width='150px' height='100px'>";
       echo "<div class='inforest'>";
       echo "<h1 class='titlerest'>".$linha['nm_restaurante']."</h1>";
       echo "<p class='categ'>Categoria: <span class='spancateg'>".$linha['nm_categoria']."</span></p>";
       echo "<div class='boxmap'>";
       echo "<a href='recompensas.php?recompensas=".$linha['cd_cnpj_restaurante']."'><button class='trocapontos'>Recompensas</button></a>";
       echo "<a href='mapa.php?local=".$linha['cd_cnpj_restaurante']."'><i class='fas fa-map-marker-alt tam'></i></a>";
       echo "</div>";
       echo "</div>";
      }
    }
  }
  
  public function imagemRestaurante($cnpj)
  {
    return clsPratos::imgRestaurante($cnpj);
  }

  public function listarPratos($cnpj="")
  {
    $comando =  "select * ";
    $comando .= "from tipo_prato ";
    $comando .= "where cd_cnpj_restaurante = '".$cnpj."' ";
    if (clsPratos::consultar($comando, $dados) === true)
    {
      while ($linha = $dados->fetch_array()) 
      {
       echo "<h1 class='sectioncardapio'>".$linha['nm_tipo_prato']."</h1>";
       $comando2 = "select * ";
       $comando2 .= "from prato ";
       $comando2 .= "join tipo_prato ";
       $comando2 .= "where prato.cd_tipo_prato = tipo_prato.cd_tipo_prato ";
       $comando2 .= "and prato.cd_cnpj_restaurante = tipo_prato.cd_cnpj_restaurante ";
       $comando2 .= "and prato.cd_cnpj_restaurante = '".$cnpj."' ";
       $comando2 .= "and prato.cd_tipo_prato = '".$linha['cd_tipo_prato']."' ";
       if (clsPratos::consultar($comando2, $dados2) === true)
        {
          while ($linha = $dados2->fetch_array()) 
          {
            if ($linha['cd_img_prato'] == "" or is_null($linha['cd_img_prato'])) 
            {
            echo "<a href='prato.php?prato=".$linha['cd_prato']."' class='infoprato'>";
           echo "<div class='pratos'>";
           echo "<div class='descpratos'>";
           echo "<div class='mid'>";
           echo "<h2 class='nomeprato'>".$linha['nm_prato']."</h2>";
           echo "<p class='ingredientes'>".substr($linha['ds_ingredientes_prato'],0,70)."<span class='readmore'>...</span></p>";
           echo "<p class='preco'>".$linha['vl_preco_prato']."</p>";
           echo "</div>";
           echo "</div>";
           echo "<div class='imgprato'>";
           echo "<img src='nophoto1000.png'>";
           echo "</div>";
           echo "</div>";
           echo "</a>";
            }
          else
          {
           echo "<a href='prato.php?prato=".$linha['cd_prato']."' class='infoprato'>";
           echo "<div class='pratos'>";
           echo "<div class='descpratos'>";
           echo "<div class='mid'>";
           echo "<h2 class='nomeprato'>".$linha['nm_prato']."</h2>";
           echo "<p class='ingredientes'>".substr($linha['ds_ingredientes_prato'],0,70)."<span class='readmore'>...</span></p>";
           echo "<p class='preco'>".$linha['vl_preco_prato']."</p>";
           echo "</div>";
           echo "</div>";
           echo "<div class='imgprato'>";
           echo "<img src='".$linha['cd_img_prato']."' width='120px' height='80px'>";
           echo "</div>";
           echo "</div>";
           echo "</a>";
          }
        }
      }
    }
  }
}

  public function codigoPratoRestaurante($p)
  {
    return clsPratos::nomeRestaurantePrato($p);
  }

  public function nomeRestaurantePrato($p="")
  {
    $comando = "select * from prato join restaurante where prato.cd_cnpj_restaurante = restaurante.cd_cnpj_restaurante and prato.cd_prato = '".$p."' ";
    if (clsPratos::consultar($comando, $dados) === true)
    {
      while ($linha = $dados->fetch_array()) 
      {
       echo "<p class='nmrestaurante'>".$linha['nm_restaurante']."</p>";
      }
    }
  }

  public function codigoPrato($prato)
  {
    return clsPratos::descPrato($prato);
  }

  public function descPrato($prato="")
  {
    $comando = "select * from prato where cd_prato = '".$prato."' ";
    if (clsPratos::consultar($comando, $dados) === true)
    {
      while ($linha = $dados->fetch_array()) 
      {
       echo "<div class='wrapprato'>";
       echo "<div class='boxpicprato'>";
       echo "<img src='".$linha['cd_img_prato']."' width='310px' height='165px'>";
       echo "</div>";
       echo "<div class='boxInfo'>";
       echo "<h1 class='tituloPrato'>".$linha['nm_prato']."</h1>";
       echo "<p class='descPrato2'>".$linha['ds_ingredientes_prato']."</p>";
       echo "<p class='preco2'>".$linha['vl_preco_prato']."</p>";
       echo "</div>";
       echo "</div>";
      }
    }
  }

  public function verificarRestaurante($cnpj)
  {
    return clsPratos::listarPratos($cnpj);
  }
}
  ?>