<?php
	require_once("assets/header.php");
	$usuario = new clsPratos();
	 if ( !isset($_SESSION["login"] ) )
    {
        Header("Location:login.php");
    }
?>  
	<nav class="infobar">
		<nav class="telar">
			<a href="index.php"><i class='fas fa-chevron-left'></i></a>
			<p class="nmrestaurante">Cardápio</p>
			<?php
					  if (isset($_GET["cnpj"]))
				  {
				  	$cnpj = $_GET["cnpj"];
				  	$obj = new clsRestaurante();
				    $obj->cdRest($cnpj);
				  }
				  else
				  {
				  	header("Location:restaurantes.php");
				  }
				?>
		</nav>
	</nav>
		<div class="wrapcontentrest">
			<header class="headRestContent">
				<?php
					  if (isset($_GET["cnpj"]))
				  {
				  	$cnpj = $_GET["cnpj"];
				    $usuario->imagemRestaurante($cnpj);
				  }
				  else
				  {
				  	header("Location:restaurantes.php");
				  }
				?>
			</header>
			<section class="horariosrest">
				<p class="diasemana"><select name="diasemana" id="funcionamento"></select></p><p class="funcionamento"></p>
			</section>
			<article class="cardapio">
				<?php
					  if (isset($_GET["cnpj"]))
				  {
				  	$cnpj = $_GET["cnpj"];
				    $usuario->verificarRestaurante($cnpj);
				  }
				  else
				  {
				  	header("Location:restaurantes.php");
				  }
				?>
			</article>
		</div>
		<div class='msgalert 1'>Adicionado aos Favoritos</div>
		<div class='msgalert 2'>Removido dos Favoritos</div>
	</div>
			<?php 
			require_once('assets/footer.php');
		?>
	</main>
	
</body>
<script type="text/javascript">
	$(document).ready(function() {
		$('.1').hide();
		$('.2').hide();
		$('#fav').click(function(){
			var x = document.getElementById('fav');
			if (x.getAttribute('data-action') == 1) 
			{
			var id = $(this).attr("value");
			$.ajax({
						url: "favoritar.php",
						method: "post",
						data: {id:id},
						dataType:"text",
						success:function(data)
						{
							$("#fav").removeClass('far');
							$("#fav").addClass('fas');
							x.setAttribute('data-action' , 2);
							$('.1').fadeIn(700);
							$('.1').delay(600).fadeOut(900);
						}
					});
			}
			else
			{
			var id = $(this).attr("value");
			$.ajax({
						url: "desfavoritar.php",
						method: "post",
						data: {id:id},
						dataType:"text",
						success:function(data)
						{
							$("#fav").removeClass('fas');
							$("#fav").addClass('far');
							x.setAttribute('data-action' , 1);
							$('.2').fadeIn(700);
							$('.2').delay(600).fadeOut(900);
						}
					});
			}
		});
		var cnpj = $('#fav').attr("value");
			$.ajax({
						url: "funcionamento.php",
						method: "post",
						data: {cnpj:cnpj},
						dataType:"text",
						success:function(data)
						{
							$("#funcionamento").html(data);
						}
					});
		var cnpj = $('#fav').attr("value");
		var value = $('#funcionamento').val();
			$.ajax({
						url: "horario_hoje.php",
						method: "post",
						data: {cnpj:cnpj, value:value},
						dataType:"text",
						success:function(data)
						{
							$(".funcionamento").html(data);
						}
					});
		$('select').change(function(){
		var cnpj = $('#fav').attr("value");
		var value = $('#funcionamento').val();
    		$.ajax({
        url: "horario.php",
        data: {value:value,cnpj:cnpj},
        dataType:"html",
        type: "post",
        success: function(data){
           $('.funcionamento').empty().append(data);
        }
    		});
		});
	});
</script>
</html>