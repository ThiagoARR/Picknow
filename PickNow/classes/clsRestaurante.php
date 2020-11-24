<?php
  
  class clsRestaurante extends clsBanco {

  private $cd_cnpj_restaurante;
  private $nm_restaurante;
  private $cd_cardapio;
  private $cd_categoria;
  private $nm_categoria;
  private $cd_img_restaurante;
  private $cd_recompensa;
  private $nm_recompensa;
  private $ds_recompensa;
  private $qt_pontos_troca;
  private $cd_cupom;
  private $latitude;
  private $longitude;
  private $pesquisa;
  private $diasemana;
  private $diasemanahoje;


  public function getCd_recompensa(){
    return $this->cd_recompensa;
  }

  public function setCd_recompensa($cd_recompensa){
    $this->cd_recompensa = $cd_recompensa;
  }

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

  public function getCd_cardapio(){
    return $this->cd_cardapio;
  }

  public function setCd_cardapio($cd_cardapio){
    $this->cd_cardapio = $cd_cardapio;
  }

  public function getCd_categoria(){
    return $this->cd_categoria;
  }

  public function setCd_categoria($cd_categoria){
    $this->cd_categoria = $cd_categoria;
  }

  public function getNm_categoria(){
    return $this->nm_categoria;
  }

  public function setNm_categoria($nm_categoria){
    $this->nm_categoria = $nm_categoria;
  }

  public function getCd_cupom(){
    return $this->cd_cupom;
  }

  public function setCd_cupom($cd_cupom){
    $this->cd_cupom = $cd_cupom;
  }

  public function getlatitude(){
    return $this->latitude;
  }

  public function setlatitude($latitude){
    $this->latitude = $latitude;
  }

  public function getlongitude(){
    return $this->longitude;
  }

  public function setlongitude($longitude){
    $this->longitude = $longitude;
  }

  public function getpesquisa(){
    return $this->pesquisa;
  }

  public function setpesquisa($pesquisa){
    $this->pesquisa = $pesquisa;
  }

  public function getdiasemana(){
    return $this->diasemana;
  }

  public function setdiasemana($diasemana){
    $this->diasemana = $diasemana;
  }

  public function getdiasemanahoje(){
    return $this->diasemanahoje;
  }

  public function setdiasemanahoje($diasemanahoje){
    $this->diasemanahoje = $diasemanahoje;
  }


  public function listarRestaurante()
  {
    $comando = "SELECT count(*),(6371 * acos( cos( radians(".$this->getlatitude().") ) * cos( radians( cd_latitude ) ) * cos( radians( cd_longitude ) - radians(".$this->getlongitude().") ) + sin( radians(".$this->getlatitude().") ) * sin( radians( cd_latitude ) )  )) AS distancia FROM restaurante HAVING distancia < 10 ORDER BY distancia ASC ";
    if (clsRestaurante::consultar($comando, $dados) === true)
    {
      while ($linha = $dados->fetch_array()) 
      {
        if ($linha[0] > 0) 
          {
            $comando2 = "SELECT *,(6371 * acos( cos( radians(".$this->getlatitude().") ) * cos( radians( cd_latitude ) ) * cos( radians( cd_longitude ) - radians(".$this->getlongitude().") ) + sin( radians(".$this->getlatitude().") ) * sin( radians( cd_latitude ) )  )) AS distancia FROM restaurante HAVING distancia < 10 ORDER BY distancia ASC ";
            if (clsRestaurante::consultar($comando2, $dados) === true)
            {
              while ($linha = $dados->fetch_array()) 
              {
              echo "<a href='telaRestaurante.php?cnpj=".$linha['cd_cnpj_restaurante']."'>";
              echo "<div class='rest1'>";
              echo "<img src='".$linha['cd_img_restaurante']."' width='150px' height='100px'>";
              echo "<div class='descRest'>";
              echo "<h3 class='titleRest'>".substr($linha['nm_restaurante'],0,18)."</h3>";
              echo "<i class='fas fa-map-marker-alt'><span class='distance'>".round($linha['distancia'],1)." Km</span></i>";
              echo "<span></span>";
              echo "</div>";
              echo "</div>";
              echo "</a>";
              }
            }
            else
            {
             echo "erro";
            }
          }
        else
          {
            echo "erro";
          }
      } 
    }
    else
    {
      echo "erro";
    }
  }
  public function loc($local)
  {
     return clsRestaurante::mapaRest($local);
  }
  public function mapaRest($local="")
  {
    $comando = "select * ";
    $comando .= "from restaurante ";
    $comando .= "where cd_cnpj_restaurante = '".$local."' ";
    if (clsRestaurante::consultar($comando, $dados) === true) 
    {
       while ($linha = $dados->fetch_array()) 
        {
        echo "<script>
              var map;
              var coord = {lat:".$linha['cd_latitude']." , lng:".$linha['cd_longitude']."};
              function getLocation()
              {
              if (navigator.geolocation)
                {
                navigator.geolocation.getCurrentPosition(initMap,error);
                }
              }
              function initMap(position) {
                var directionsService = new google.maps.DirectionsService();
                var directionsDisplay = new google.maps.DirectionsRenderer();
                var usuario = {lat:position.coords.latitude , lng:position.coords.longitude};
                map = new google.maps.Map(document.getElementById('map'), {
                  center: {lat:".$linha['cd_latitude']." , lng:".$linha['cd_longitude']."},
                  zoom: 15
                });
                directionsDisplay.setMap(map);
                var request = {
                  origin: usuario,
                  destination: coord,
                  travelMode: 'DRIVING'
              };
              directionsService.route(request, function(response, status) {
                if (status == 'OK') {
                  directionsDisplay.setDirections(response);
                }
              });
              }

              function error(error){
                erro = document.getElementById('map');
                erro.innerHTML = '<p>Ative a localização para ver a rota.';
              }
              </script>";
        }
    }
  }

  public function listarRestauranteJapones()
  {
    $comando =  "SELECT *,(6371 * acos( cos( radians(".$this->getlatitude().") ) * cos( radians( cd_latitude ) ) * cos( radians( cd_longitude ) - radians(".$this->getlongitude().") ) + sin( radians(".$this->getlatitude().") ) * sin( radians( cd_latitude ) )  )) AS distancia FROM restaurante where cd_categoria = 9 ";
    if (clsRestaurante::consultar($comando, $dados) === true)
    {
      while ($linha = $dados->fetch_array()) 
      {
        echo "<a href='telaRestaurante.php?cnpj=".$linha['cd_cnpj_restaurante']."'>";
        echo "<div class='rest1'>";
        echo "<img src='".$linha['cd_img_restaurante']."' width='150px' height='100px'>";
        echo "<div class='descRest'>";
        echo "<h3 class='titleRest'>".$linha['nm_restaurante']."</h3>";
        echo "<i class='fas fa-map-marker-alt'><span class='distance'>".round($linha['distancia'],1)." Km</span></i>";
        echo "<span></span>";
        echo "</div>";
        echo "</div>";
        echo "</a>";
      }
    }
  }

  public function listarRestauranteMexicano()
  {
    $comando =  "SELECT *,(6371 * acos( cos( radians(".$this->getlatitude().") ) * cos( radians( cd_latitude ) ) * cos( radians( cd_longitude ) - radians(".$this->getlongitude().") ) + sin( radians(".$this->getlatitude().") ) * sin( radians( cd_latitude ) )  )) AS distancia FROM restaurante where cd_categoria = 1 ";
    if (clsRestaurante::consultar($comando, $dados) === true)
    {
      while ($linha = $dados->fetch_array()) 
      {
        echo "<a href='telaRestaurante.php?cnpj=".$linha['cd_cnpj_restaurante']."'>";
        echo "<div class='rest1'>";
        echo "<img src='".$linha['cd_img_restaurante']."' width='150px' height='100px'>";
        echo "<div class='descRest'>";
        echo "<h3 class='titleRest'>".$linha['nm_restaurante']."</h3>";
        echo "<i class='fas fa-map-marker-alt'><span class='distance'>".round($linha['distancia'],1)." Km</span></i>";
        echo "<span></span>";
        echo "</div>";
        echo "</div>";
        echo "</a>";
      }
    }
  }

  public function listarRestauranteMexicanoNoGps()
  {
    $comando =  "SELECT * FROM restaurante where cd_categoria = 1 ";
    if (clsRestaurante::consultar($comando, $dados) === true)
    {
      while ($linha = $dados->fetch_array()) 
      {
        echo "<a href='telaRestaurante.php?cnpj=".$linha['cd_cnpj_restaurante']."'>";
        echo "<div class='rest1'>";
        echo "<img src='".$linha['cd_img_restaurante']."' width='150px' height='100px'>";
        echo "<div class='descRest'>";
        echo "<h3 class='titleRest'>".$linha['nm_restaurante']."</h3>";
        echo "<span></span>";
        echo "</div>";
        echo "</div>";
        echo "</a>";
      }
    }
  }

  public function listarRestauranteChines()
  {
    $comando =  "SELECT *,(6371 * acos( cos( radians(".$this->getlatitude().") ) * cos( radians( cd_latitude ) ) * cos( radians( cd_longitude ) - radians(".$this->getlongitude().") ) + sin( radians(".$this->getlatitude().") ) * sin( radians( cd_latitude ) )  )) AS distancia FROM restaurante where cd_categoria = 8 ";
    if (clsRestaurante::consultar($comando, $dados) === true)
    {
      while ($linha = $dados->fetch_array()) 
      {
        echo "<a href='telaRestaurante.php?cnpj=".$linha['cd_cnpj_restaurante']."'>";
        echo "<div class='rest1'>";
        echo "<img src='".$linha['cd_img_restaurante']."' width='150px' height='100px'>";
        echo "<div class='descRest'>";
        echo "<h3 class='titleRest'>".$linha['nm_restaurante']."</h3>";
        echo "<i class='fas fa-map-marker-alt'><span class='distance'>".round($linha['distancia'],1)." Km</span></i>";
        echo "<span></span>";
        echo "</div>";
        echo "</div>";
        echo "</a>";
      }
    }
  }

  public function listarRestauranteChinesNoGps()
  {
    $comando =  "SELECT * FROM restaurante where cd_categoria = 8 ";
    if (clsRestaurante::consultar($comando, $dados) === true)
    {
      while ($linha = $dados->fetch_array()) 
      {
        echo "<a href='telaRestaurante.php?cnpj=".$linha['cd_cnpj_restaurante']."'>";
        echo "<div class='rest1'>";
        echo "<img src='".$linha['cd_img_restaurante']."' width='150px' height='100px'>";
        echo "<div class='descRest'>";
        echo "<h3 class='titleRest'>".$linha['nm_restaurante']."</h3>";
        echo "<span></span>";
        echo "</div>";
        echo "</div>";
        echo "</a>";
      }
    }
  }

  public function listarRestauranteArabe()
  {
    $comando =  "SELECT *,(6371 * acos( cos( radians(".$this->getlatitude().") ) * cos( radians( cd_latitude ) ) * cos( radians( cd_longitude ) - radians(".$this->getlongitude().") ) + sin( radians(".$this->getlatitude().") ) * sin( radians( cd_latitude ) )  )) AS distancia FROM restaurante where cd_categoria = 3 ";
    if (clsRestaurante::consultar($comando, $dados) === true)
    {
      while ($linha = $dados->fetch_array()) 
      {
        echo "<a href='telaRestaurante.php?cnpj=".$linha['cd_cnpj_restaurante']."'>";
        echo "<div class='rest1'>";
        echo "<img src='".$linha['cd_img_restaurante']."' width='150px' height='100px'>";
        echo "<div class='descRest'>";
        echo "<h3 class='titleRest'>".$linha['nm_restaurante']."</h3>";
        echo "<i class='fas fa-map-marker-alt'><span class='distance'>".round($linha['distancia'],1)." Km</span></i>";
        echo "<span></span>";
        echo "</div>";
        echo "</div>";
        echo "</a>";
      }
    }
  }

  public function listarRestauranteArabeNoGps()
  {
    $comando =  "SELECT * FROM restaurante where cd_categoria = 3 ";
    if (clsRestaurante::consultar($comando, $dados) === true)
    {
      while ($linha = $dados->fetch_array()) 
      {
        echo "<a href='telaRestaurante.php?cnpj=".$linha['cd_cnpj_restaurante']."'>";
        echo "<div class='rest1'>";
        echo "<img src='".$linha['cd_img_restaurante']."' width='150px' height='100px'>";
        echo "<div class='descRest'>";
        echo "<h3 class='titleRest'>".$linha['nm_restaurante']."</h3>";
        echo "<span></span>";
        echo "</div>";
        echo "</div>";
        echo "</a>";
      }
    }
  }

  public function dia_funcionamento()
  {
    $diahoje =  new DateTime();
    $comando = "select * from dia_semana ";
    if (clsRestaurante::consultar($comando,$dados) === true) 
    {
      while ($linha = $dados->fetch_array()) 
      {
        if ($linha['cd_dia_semana'] == $diahoje->format('w')+1) {
          echo "<option value='".$linha['cd_dia_semana']."' selected>".$linha['nm_dia_semana']."</option>";
        }
        else
        {
          echo "<option value='".$linha['cd_dia_semana']."'>".$linha['nm_dia_semana']."</option>";
        }
      }
    }
  }

  public function hora_funcionamento()
  {
    $comando = "select count(*) from horario_funcionamento join dia_semana where dia_semana.cd_dia_semana = horario_funcionamento.cd_dia_semana and cd_cnpj_restaurante = '".$this->getCd_cnpj_restaurante()."' and dia_semana.cd_dia_semana = ".$this->getdiasemana()." ";
    if (clsRestaurante::consultar($comando,$dados) === true) 
    {
      while ($linha = $dados->fetch_array()) 
      {
        if ($linha[0] == 0) 
        {
          echo "<span class='negrito'>Fechado</span>";
        }
        else
        {
          $comando2 = "select * from horario_funcionamento join dia_semana where dia_semana.cd_dia_semana = horario_funcionamento.cd_dia_semana and cd_cnpj_restaurante = '".$this->getCd_cnpj_restaurante()."' and dia_semana.cd_dia_semana = ".$this->getdiasemana()." ";
          if (clsRestaurante::consultar($comando2,$dados) === true) 
          {
            while ($linha = $dados->fetch_array()) 
            {
            echo "<span class='negrito'>Horario de Funcionamento:</span>".date('H:i',strtotime($linha['hr_abertura']))."-".date('H:i',strtotime($linha["hr_fechamento_dia_funcionamento"]))."" ;
            }
          }
        }
      }
    }
  }

  public function hora_funcionamento_hoje()
  {
    $diahoje =  new DateTime();
    $dia = $diahoje->format('w')+1;
    $comando = "select count(*) from horario_funcionamento join dia_semana where dia_semana.cd_dia_semana = horario_funcionamento.cd_dia_semana and cd_cnpj_restaurante = '".$this->getCd_cnpj_restaurante()."' and dia_semana.cd_dia_semana = '".$dia."' ";
    if (clsRestaurante::consultar($comando,$dados) === true) 
    {
      while ($linha = $dados->fetch_array()) 
      {
        if ($linha[0] == 0) 
        {
           echo "<span class='negrito'>Fechado</span>";
        }
        else
        {
          $comando2 = "select * from horario_funcionamento join dia_semana where dia_semana.cd_dia_semana = horario_funcionamento.cd_dia_semana and cd_cnpj_restaurante = '".$this->getCd_cnpj_restaurante()."' and dia_semana.cd_dia_semana = '".$dia."' ";
          if (clsRestaurante::consultar($comando2,$dados) === true) 
          {
            while ($linha = $dados->fetch_array()) 
            {
            echo "<span class='negrito'>Horario de Funcionamento:</span>".date('H:i',strtotime($linha['hr_abertura']))."-".date('H:i',strtotime($linha["hr_fechamento_dia_funcionamento"]))."" ;
            }
          }
        }
      }
    }
  }

   public function listarRestauranteJaponesNoGps()
  {
    $comando =  "SELECT * FROM restaurante where cd_categoria = 9 ";
    if (clsRestaurante::consultar($comando, $dados) === true)
    {
      while ($linha = $dados->fetch_array()) 
      {
        echo "<a href='telaRestaurante.php?cnpj=".$linha['cd_cnpj_restaurante']."'>";
        echo "<div class='rest1'>";
        echo "<img src='".$linha['cd_img_restaurante']."' width='150px' height='100px'>";
        echo "<div class='descRest'>";
        echo "<h3 class='titleRest'>".$linha['nm_restaurante']."</h3>";
        echo "<span></span>";
        echo "</div>";
        echo "</div>";
        echo "</a>";
      }
    }
  }

  public function listarPesquisa()
  {
    $comando = "select distinct restaurante.cd_cnpj_restaurante,nm_restaurante, categoria.nm_categoria, restaurante.cd_img_restaurante from restaurante ";
    $comando .= "join prato ";
    $comando .= "on restaurante.cd_cnpj_restaurante = prato.cd_cnpj_restaurante ";
    $comando .= "join categoria ";
    $comando .= "on restaurante.cd_categoria = categoria.cd_categoria ";
    $comando .= "where nm_restaurante like '%".$this->getpesquisa()."%' ";
    $comando .= "or (nm_categoria like '%".$this->getpesquisa()."%') order by nm_restaurante ";
    if (clsRestaurante::consultar($comando, $dados) === true)
    {
      while ($linha = $dados->fetch_array()) 
      {
    echo "<a href='telaRestaurante.php?cnpj=".$linha['cd_cnpj_restaurante']."'><div class='resultPesquisaR'>
          <div class='logoText'>
            <img src='".$linha['cd_img_restaurante']."' width='100px' height='70px'>
          </div>
          <div class='informacoesR'>
            <h2 class='nomeprato'>".$linha['nm_restaurante']."</h2>
            <p class='ingredientes'><span>Categoria:</span>".$linha['nm_categoria']."</p>
          </div>
        </div>
        </a>";
      }
    }
    $comando2 = "select * from restaurante ";
    $comando2 .= "join prato ";
    $comando2 .= "on restaurante.cd_cnpj_restaurante = prato.cd_cnpj_restaurante ";
    $comando2 .= "join categoria ";
    $comando2 .= "on restaurante.cd_categoria = categoria.cd_categoria ";
    $comando2 .= "where nm_restaurante like '%".$this->getpesquisa()."%' ";
    $comando2 .= "or (nm_prato like '%".$this->getpesquisa()."%') ";
    $comando2 .= "or (ds_ingredientes_prato like '%".$this->getpesquisa()."%') ";
    $comando2 .= "or (nm_categoria like '%".$this->getpesquisa()."%') order by nm_prato";
    if (clsRestaurante::consultar($comando2,$dados) === true) 
    {
      while ($linha = $dados->fetch_array()) 
      {
         if ($linha['cd_img_prato'] == "") 
        {
       echo "<a href='prato.php?prato=".$linha['cd_prato']."' class='resultPesquisaP'>";
       echo "<div class='pratosPesquisa'>";
       echo "<div class='descpratos'>";
       echo "<div class='mid'>";
       echo "<h2 class='nomeprato'>".$linha['nm_prato']."</h2>";
       echo "<p class='ingredientes'>".substr($linha['ds_ingredientes_prato'],0,70)."<span class='readmore'>...</span></p>";
       echo "<p class='preco'>".$linha['vl_preco_prato']."</p><p class='restnm'>".$linha['nm_restaurante']."</p>";
       echo "</div>";
       echo "</div>";
       echo "<div class='imgprato'>";
       echo "<img src='nophoto100.png'>";
       echo "</div>";
       echo "</div>";
       echo "</a>";
        }
        else
        {
          echo "<a href='prato.php?prato=".$linha['cd_prato']."' class='resultPesquisaP'>";
       echo "<div class='pratosPesquisa'>";
       echo "<div class='descpratos'>";
       echo "<div class='mid'>";
       echo "<h2 class='nomeprato'>".$linha['nm_prato']."</h2>";
       echo "<p class='ingredientes'>".substr($linha['ds_ingredientes_prato'],0,70)."<span class='readmore'>...</span></p>";
       echo "<p class='preco'>".$linha['vl_preco_prato']."</p><p class='restnm'>".$linha['nm_restaurante']."</p>";
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

  public function listarRestauranteItaliana()
  {
    $comando =  "SELECT *,(6371 * acos( cos( radians(".$this->getlatitude().") ) * cos( radians( cd_latitude ) ) * cos( radians( cd_longitude ) - radians(".$this->getlongitude().") ) + sin( radians(".$this->getlatitude().") ) * sin( radians( cd_latitude ) )  )) AS distancia FROM restaurante where cd_categoria = 10 ";
    if (clsRestaurante::consultar($comando, $dados) === true)
    {
      while ($linha = $dados->fetch_array()) 
      {
        echo "<a href='telaRestaurante.php?cnpj=".$linha['cd_cnpj_restaurante']."'>";
        echo "<div class='rest1'>";
        echo "<img src='".$linha['cd_img_restaurante']."' width='150px' height='100px'>";
        echo "<div class='descRest'>";
        echo "<h3 class='titleRest'>".$linha['nm_restaurante']."</h3>";
        echo "<i class='fas fa-map-marker-alt'><span class='distance'>".round($linha['distancia'],1)." Km</span></i>";
        echo "<span></span>";
        echo "</div>";
        echo "</div>";
        echo "</a>";
      }
    }
  }

  public function listarRestauranteItalianaNoGps()
  {
    $comando =  "SELECT * FROM restaurante where cd_categoria = 10 ";
    if (clsRestaurante::consultar($comando, $dados) === true)
    {
      while ($linha = $dados->fetch_array()) 
      {
        echo "<a href='telaRestaurante.php?cnpj=".$linha['cd_cnpj_restaurante']."'>";
        echo "<div class='rest1'>";
        echo "<img src='".$linha['cd_img_restaurante']."' width='150px' height='100px'>";
        echo "<div class='descRest'>";
        echo "<h3 class='titleRest'>".$linha['nm_restaurante']."</h3>";
        echo "<span></span>";
        echo "</div>";
        echo "</div>";
        echo "</a>";
      }
    }
  }
      public function listarRecompensas($cnpj="")
  {
    $comando =  "select count(*) ";
    $comando .= "from recompensas ";
    $comando .= "where cd_cnpj_restaurante = '".$cnpj."'";
    if (clsRestaurante::consultar($comando, $dados) === true)
    {
      while ($linha = $dados->fetch_array()) 
      {
        if ($linha[0] > 0) 
        {
          $comando =  "select * ";
          $comando .= "from recompensas ";
          $comando .= "where cd_cnpj_restaurante = '".$cnpj."'";
          if (clsRestaurante::consultar($comando, $dados) === true)
          {
            while ($linha = $dados->fetch_array()) 
            {
              echo"<div class='premio'>";
              echo"<img class='imgpremio' src='outback.jpg' width='80px' height='80px'>";
              echo"<div class='info'>";
              echo"<h2 class='nomeRestaurante'>".$linha['nm_recompensa']."</h2>";
              echo"<p class='descRestaurante'>".$linha['ds_recompensa']."</p>";
              echo"</div>";
              echo"<div class='boxbtn'>";
              echo"<p>".$linha['qt_pontos_troca']." pts</p>";
              echo"<div class='pontostroca' data-toggle='modal' data-target='#modalAceitar".$linha['cd_recompensa']."'>";
              echo"Resgatar";
              echo"</div>";
              echo"</div>";
              echo"<div class='modal' id='modalAceitar".$linha['cd_recompensa']."' tabindex='-1' role='dialog'>";
              echo"<div class='modal-dialog' role='document'>";
              echo"<div class='modal-content'>";
              echo"<div class='modal-header'>";
              echo"<h5 class='modal-title'>Resgatar Cupom</h5>";
              echo"<button type='button' class='close' data-dismiss='modal' aria-label='Fechar'>";
              echo"<span aria-hidden='true'>&times;</span>";
              echo"</button>";
              echo"</div>";
              echo"<div class='modal-body'>";
              echo"<p>Tem certeza que deseja resgatar o cupom ".$linha['nm_recompensa']." por ".$linha['qt_pontos_troca']." pontos?</p>";
              echo"</div>";
              echo"<div class='modal-footer'>";
              echo"<button type='button' class='btn btn-secondary' data-dismiss='modal'>Não</button>";
              echo"<form action='resgatarRecompensa.php?codigo=".$linha['cd_recompensa']."&recompensas=".$cnpj."' method='POST'>";
              echo"<button type='submit' class='btn btn-primary'>Sim</button>";
              echo"</form>";
              echo"</div>";
              echo"</div>";
              echo"</div>";
              echo"</div>";
              echo"</div>";
            }
          }
        }
        else
        {
          echo "<div class='errormsg'>Não há recompensas disponiveis no momento.</div>";
        }

      }
    }
  }

  public function cdRest($cnpj)
  {
    return clsRestaurante::favRest($cnpj);
  }

  public function favRest($cnpj="")
  {
    $comando = "select count(*) from lugares_favoritos where cd_cnpj_restaurante = '".$cnpj."'";
    if (clsRestaurante::consultar($comando, $dados) === true)
    {
      while ($linha = $dados->fetch_array()) 
      {
        if ($linha[0] == 0) 
        {
          echo "<i class='far fa-heart' data-action='1' id='fav' value='".$cnpj."'></i>";
        }
        else
        {
          echo "<i class='fas fa-heart' data-action='2' id='fav' value='".$cnpj."'></i>";
        }
      }
    }
    else
    {
      return false;
    }

  }

  public function cnpjRecompensa($cnpj)
  {
    return clsRestaurante::listarRecompensas($cnpj);
  }

   public function cnpjRest($cnpj)
  {
    return clsRestaurante::infoRest($cnpj);
  }

  public function infoRest($cnpj="")
  {
    $comando = "select * from restaurante where cd_cnpj_restaurante = '".$cnpj."'";
    if (clsRestaurante::consultar($comando, $dados) === true)
    {
      while ($linha = $dados->fetch_array()) 
      {
        echo "<div class='imgRestPremio'>";
        echo "<img src='".$linha['cd_img_restaurante']."' width='200px' height='110px'>";
        echo "</div>";
        echo "<h2 class='nr'>".$linha['nm_restaurante']."</h2>";
        echo "<p class='np'>Promoções Disponiveis</p>";
      }
    }
    else
    {
      return false;
    }

  }

  public function favoritar()
  {
    $comando = "insert into lugares_favoritos values ('".$this->getCd_cnpj_restaurante()."','".$_SESSION["login"]."')";
    if (clsRestaurante::executar($comando))
        {
          return true;
        }
    else
        {
          return false;  
        }
  }

  public function desfavoritar()
  {
    $comando = "delete from lugares_favoritos where cd_cnpj_restaurante = '".$this->getCd_cnpj_restaurante()."' ";
    if (clsRestaurante::executar($comando))
        {
          return true;
        }
    else
        {
          return false;  
        }
  }

  public function restauranteVisitado()
  {
    $comando = "select count(*) from lugares_visitados ";
    $comando .= "join restaurante where cd_cpf_cliente = '".$_SESSION["login"]."' and lugares_visitados.cd_cnpj_restaurante = restaurante.cd_cnpj_restaurante order by dt_visita desc";
    if(clsRestaurante::consultar($comando, $dados) === true)
    {
      while ($linha = $dados->fetch_array()) 
      {
        if ($linha[0] > 0) 
        {
           $comando = "select * from lugares_visitados ";
           $comando .= "join restaurante where cd_cpf_cliente = '".$_SESSION["login"]."' and lugares_visitados.cd_cnpj_restaurante = restaurante.cd_cnpj_restaurante order by dt_visita desc";
           if(clsRestaurante::consultar($comando, $dados) === true)
           {
             while ($linha = $dados->fetch_array()) 
             {
              echo "<div class='wraplastplaces cd".$linha['cd_historico']."'>";
              echo "<div class='boxlastplaces dc".$linha['cd_historico']."'>";
              echo "<div class='date'>";
              echo "<p>".date('d/m',strtotime($linha["dt_visita"]))."</p>";
              echo "</div>";
              echo "<div class='imgplace'>";
              echo "<img src='".$linha['cd_img_restaurante']."' width='50px' height='45px'>";
              echo "</div>";
              echo "<div class='nameplace'>";
              echo "<p>".$linha['nm_restaurante']."</p>";
              echo "</div>";
              echo "<div>";
              echo "<p class='more".$linha['cd_historico']."'>+</p>";
              echo "</div>";
              echo "</div>";
              echo "<div>";
              echo "<p class='valorgasto valorgasto".$linha['cd_historico']."'>Valor Gasto: R$".$linha['vl_compra']."</p>";
              echo "<p class='pontosganhos valorgasto".$linha['cd_historico']."'>Pontos Ganhos: +".$linha['vl_ponto']."</p>";
              echo "</div>";
              echo "<div class='set'>";
              echo "<i class='fas fa-chevron-up fa-chevron-up".$linha['cd_historico']." seta".$linha['cd_historico']."'></i>";
              echo "</div>";
              echo "</div>";

             }
           }
           else
           {
            return false;
           }
         }
         else
         {
          echo "<div class='errormsg'>Você ainda não visitou nenhum restaurante.</div>";
         }
      }
    }
  }

  public function listarJsvisits()
  {
    $comando = "select count(*) from lugares_visitados ";
    $comando .= "join restaurante where cd_cpf_cliente = '".$_SESSION["login"]."' and lugares_visitados.cd_cnpj_restaurante = restaurante.cd_cnpj_restaurante order by dt_visita desc";
    if(clsRestaurante::consultar($comando, $dados) === true)
    {
      while ($linha = $dados->fetch_array()) 
      {
        if ($linha[0] > 0) 
        {
           $comando = "select * from lugares_visitados ";
           $comando .= "join restaurante where cd_cpf_cliente = '".$_SESSION["login"]."' and lugares_visitados.cd_cnpj_restaurante = restaurante.cd_cnpj_restaurante order by dt_visita desc";
           if(clsRestaurante::consultar($comando, $dados) === true)
           {
             while ($linha = $dados->fetch_array()) 
             {
              echo "<script type='text/javascript'>";
              echo "$(document).ready(function() {";
              echo "$('.dc".$linha['cd_historico']."').click(function() {";
              echo "$('.cd".$linha['cd_historico']."').animate({height:'150px'}, 30);";
              echo "$('.valorgasto".$linha['cd_historico']."').show(100);";
              echo "$('.fa-chevron-up".$linha['cd_historico']."').show(300);";
              echo "});";
              echo "$('.fa-chevron-up".$linha['cd_historico']."').click(function() {";
              echo "$('.cd".$linha['cd_historico']."').animate({height:'49px'}, 30);";
              echo "$('.valorgasto".$linha['cd_historico']."').hide(100);";
              echo "$('.fa-chevron-up".$linha['cd_historico']."').hide(300);";
              echo "});";
              echo "});";
              echo "</script>";
            }
          }
        }  
      }
    }
    else
    {
      return false;
    }
  }

  public function qtdVisitado()
  {
    $comando = "select count(distinct cd_cnpj_restaurante) as total from lugares_visitados ";
    $comando .= "where cd_cpf_cliente = '".$_SESSION["login"]."'";
    if(clsRestaurante::consultar($comando, $dados) === true)
    {
      while ($linha = $dados->fetch_array()) 
      {
        echo "<div class='wrapvisitados'><i class='fas fa-utensils'></i> <p class='sectionVisitados'>";
        echo "Restaurantes Visitados</p><p class='qtdVisit'>".$linha['total']."</p></div>";
      }
    }
  }

  public function listarFavorito()
  {
    $comando = "select count(*) from lugares_favoritos join restaurante join categoria where cd_cpf_cliente = '".$_SESSION['login']."' and restaurante.cd_cnpj_restaurante = lugares_favoritos.cd_cnpj_restaurante and restaurante.cd_categoria = categoria.cd_categoria ";
    if (clsRestaurante::consultar($comando, $dados) === true)
    {
      while ($linha = $dados->fetch_array()) 
      {
        if ($linha[0] > 0) 
        {
           $comando = "select * from lugares_favoritos join restaurante join categoria where cd_cpf_cliente = '".$_SESSION['login']."' and restaurante.cd_cnpj_restaurante = lugares_favoritos.cd_cnpj_restaurante and restaurante.cd_categoria = categoria.cd_categoria ";
           if(clsRestaurante::consultar($comando, $dados) === true)
           {
             while ($linha = $dados->fetch_array()) 
             {
             echo "<a href='telaRestaurante.php?cnpj=".$linha['cd_cnpj_restaurante']."'><div class='itemfavorito'>
          <div class='logoText'>
            <img src='".$linha['cd_img_restaurante']."' width='100px' height='70px'>
          </div>
          <div class='informacoesR'>
            <h2 class='nomeprato'>".$linha['nm_restaurante']."</h2>
            <p class='ingredientes'><span>Categoria:</span>".$linha['nm_categoria']."</p>
          </div>
        </div>
        </a>";
             }
           }
           else
           {
            return false;
           }
         }
         else
         {
          echo "<div class='errormsg'>Você ainda não favoritou nenhum restaurante.</div>";
         }
      }
  }
}
  public function trocarPonto()
  {
    $comando = "select cliente.qt_pontos - recompensas.qt_pontos_troca as subpontos ";
    $comando .= "from cliente ";
    $comando .= "join recompensas ";
    $comando .= "where recompensas.cd_recompensa = '".$this->getCd_recompensa()."' ";
    $comando .= "and cliente.cd_cpf_cliente = '".$_SESSION["login"]."'";
    if (clsRestaurante::consultar($comando, $dados) === true)
    {
      while ($linha = $dados->fetch_array()) 
      {
        $pontos = $linha['subpontos'];
        if ($pontos >= 0) 
        {
          $comando2 = "update cliente set qt_pontos = '".$pontos."' where cd_cpf_cliente = '".$_SESSION['login']."' ";
            if (clsRestaurante::executar($comando2))
            {
              $comando3 = "insert into cupom values ('".$_SESSION["login"]."','".$this->getCd_recompensa()."','".$this->getCd_cnpj_restaurante()."','".$this->getCd_cupom()."',NOW(), DATE_ADD(NOW(), INTERVAL 2 MONTH),0)";
              if (clsRestaurante::executar($comando3))
              {
               $comando4 = "select count(*) as resultado from trocas_efetuadas where cd_cpf_cliente = '".$_SESSION["login"]."'";
               if (clsRestaurante::consultar($comando, $dados) === true)
                  {
                    while ($linha = $dados->fetch_array()) 
                    {
                      $resultado = $linha['resultado'];
                      if ($resultado > 0) 
                      {
                        $comando5 = "update trocas_efetuadas set qt_trocas = qt_trocas + 1 where cd_cpf_cliente = '".$_SESSION["login"]."' ";
                         if (clsRestaurante::executar($comando5))
                         {
                          return true;
                         }
                      }
                      else
                      {
                        $comando6 = "insert into trocas_efetuadas values (1,'".$_SESSION["login"]."')";
                        if (clsRestaurante::executar($comando6))
                        {
                          return true;
                        }
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
              return false;
            }
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
  ?>