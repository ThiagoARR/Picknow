<?php
require_once('assets/header.php');

	 if ( !isset($_SESSION["login"] ) )
    {
        Header("Location:login.php");
    }
?>  
<nav class="infobarrest">
		<nav class="wrapiconsrest">
			<?php
						$usuario = new clsCliente();
						$usuario->infoBar();
					?>
		</nav>
	</nav>
		<div class="wrap_head_body_index">
			<header class="headContent">
				<div class="wrap_headContent">
					<h1 class="titleHome">Encontre o melhor restaurante para comer</h1>
					<div class="boxsearchbar">
						<i class="fas fa-chevron-left exit"></i><input type="text" name="searchbar" class="searchbar" id="searchbar">
					</div>
				</div>
				<div class="boxTipoResultado">
                	<div class="abaRestaurante" id="abaR">
                    	<p>Restaurantes</p>
                    	<div class="barraR"></div>
                	</div>
                	<div class="abaPratos" id="abaP">
                    	<p>Pratos</p>
                    	<div class="barraP"></div>
                	</div>
            	</div>
			</header>
			<article class="wrapboxPesquisa">
				
            	<div class="boxPesquisa">
            		
            	</div>
			</article>
			<article class="bodyContent">
				<div class="wrap_restProx1">
					<h2 class="titleSection">Restaurantes Mais Próximos</h2>
					<section class="restProx">
					</section>
				</div>
				<div class="wrap_restProx">
					<h2 class="titleSection">Culinária Japonesa</h2>
					<section class="restJapa">
					</section>
				</div>
				<div class="wrap_restProx">
					<h2 class="titleSection">Culinária Italiana</h2>
					<section class="restItal">
					</section>
				</div>
				<div class="wrap_restProx">
					<h2 class="titleSection">Culinária Mexicana</h2>
					<section class="restMex">
					</section>
				</div>
				<div class="wrap_restProx">
					<h2 class="titleSection">Culinária Chinesa</h2>
					<section class="restChin">
					</section>
				</div>
				<div class="wrap_restProx">
					<h2 class="titleSection">Culinária Arabe</h2>
					<section class="restArab">
					</section>
				</div>
			</article>
		</div>
	</div>
		<?php 
			require_once('assets/footer.php');
		?>
	</main>
</body>
<script type="text/javascript">
		              if (navigator.geolocation)
		                {
		                navigator.geolocation.getCurrentPosition(sendPosition,error);
		                }
		function sendPosition(position){
			var lat = position.coords.latitude;
			var lng = position.coords.longitude;
			$.ajax({
						url: "lugarProximo.php",
						method: "post",
						data: {lat:lat, lng:lng},
						dataType:"text",
						success:function(data)
						{
							$('.restProx').html(data);
						}
					});
			$.ajax({
						url: "japones.php",
						method: "post",
						data: {lat:lat, lng:lng},
						dataType:"text",
						success:function(data)
						{
							$('.restJapa').html(data);
						}
					});
			$.ajax({
						url: "italiano.php",
						method: "post",
						data: {lat:lat, lng:lng},
						dataType:"text",
						success:function(data)
						{
							$('.restItal').html(data);
						}
					});
			$.ajax({
						url: "mexicano.php",
						method: "post",
						data: {lat:lat, lng:lng},
						dataType:"text",
						success:function(data)
						{
							$('.restMex').html(data);
						}
					});
			$.ajax({
						url: "chines.php",
						method: "post",
						data: {lat:lat, lng:lng},
						dataType:"text",
						success:function(data)
						{
							$('.restChin').html(data);
						}
					});
			$.ajax({
						url: "arabe.php",
						method: "post",
						data: {lat:lat, lng:lng},
						dataType:"text",
						success:function(data)
						{
							$('.restArab').html(data);
						}
					});
		}

		function error(error){
			$('.wrap_restProx1').hide();
			$.ajax({
						url: "japonesnogps.php",
						method: "post",
						dataType:"text",
						success:function(data)
						{
							$('.restJapa').html(data);
						}
					});
			$.ajax({
						url: "italianonogps.php",
						method: "post",
						dataType:"text",
						success:function(data)
						{
							$('.restItal').html(data);
						}
					});
			$.ajax({
						url: "mexicano.php",
						method: "post",
						dataType:"text",
						success:function(data)
						{
							$('.restMex').html(data);
						}
					});
			$.ajax({
						url: "chines.php",
						method: "post",
						dataType:"text",
						success:function(data)
						{
							$('.restChin').html(data);
						}
					});
			$.ajax({
						url: "arabe.php",
						method: "post",
						dataType:"text",
						success:function(data)
						{
							$('.restArab').html(data);
						}
					});
		}
		$(document).ready(function(){
			$(".abaRestaurante").click(function(){
				$(".resultPesquisaR").css("display","flex");
				$(".resultPesquisaP").css("display","none");
				$(".barraR").css("background-color","red");
				$(".barraP").css("background-color","white");
			});

			$(".abaPratos").click(function(){
				$(".resultPesquisaP").css("display","flex");
				$(".resultPesquisaR").css("display","none");
				$(".barraP").css("background-color","red");
				$(".barraR").css("background-color","white");

			});

			$( ".searchbar" ).click(function() {
				$(".titleHome").hide();
				$(".wrapiconsrest").hide();
				$(".exit").show();
			 	$(".infobarrest").css("height","0px");
			 	$(".infobarrest").css("padding-top","00px");
			 	$(".infobarrest").css("padding-bottom","00px");
			 	$(".headContent").css("height","auto");
			 	$(".headContent").css("padding-top","0px");
			 	$(".headContent").css("padding","10px");
			 	$(".searchbar").css("width","280px");
			 	$(".wrap_head_body_index").css("height","670px");
			 	
			});

			$( ".exit" ).click(function() {
				$(".titleHome").show();
				$(".wrapiconsrest").show();
				$(".exit").hide();
			 	$(".infobarrest").css("height","55px");
			 	$(".infobarrest").css("padding-top","10px");
			 	$(".infobarrest").css("padding-bottom","10px");
			 	$(".headContent").css("height","200px");
			 	$(".headContent").css("padding","0px");
			 	$(".headContent").css("padding-top","30px");
			 	$(".searchbar").css("width","250px");
			 	$(".wrap_head_body_index").css("height","600px");
				$(".resultPesquisaR").css("display","none");
				$(".resultPesquisaP").css("display","none");
				$('.boxTipoResultado').css("display","none");
				$(".bodyContent").show();
				$('#searchbar').val('');

			 	
			});

			$('#searchbar').keyup(function(){
			 	$(".bodyContent").hide();
			 	$(".wrapboxPesquisa").show();
				$('.boxTipoResultado').css("display","flex");
				var txt = $(this).val();
				if (txt != '') 
				{
					$('.boxPesquisa').html('');
					$.ajax({
						url: "pesquisa.php",
						method: "post",
						data: {search:txt},
						dataType:"text",
						success:function(data)
						{
							$('.boxPesquisa').html(data);
							$(".barraR").css("background-color","red");
							$(".barraP").css("background-color","white");
						}
					});
				}
				else
				{
					
				}
			});
			});
</script>
</html>