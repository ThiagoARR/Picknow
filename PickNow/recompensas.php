<?php
	require_once('assets/header.php');

	 if ( !isset($_SESSION["login"] ) )
    {
        Header("Location:login.php");
    }
    $usuario = new clsRestaurante();
?>  
<nav class="infobar">
		<nav class="wrapicons">
			<?php
			echo "<a href='".$_SERVER['HTTP_REFERER']."'><i class='fas fa-chevron-left'></i></a>";
			?>
			<p class="nmrestaurante">Recompensas</p>
		</nav>
</nav>
		<div class="wrap_head_body_recompensa">
			<p class="codigogerado">
			<?php
			if (isset($_GET['validar']) && $_GET['validar'] == '1') 
			{
					echo "<div class='msgalert'>Resgate feito com sucesso</div>";
			}
			else
				if (isset($_GET['validar']) && $_GET['validar'] == '2') 
				{
					echo "<div class='msgalert'>Pontos Insuficientes</div>";
					}
			?>
			</p>
			<div class="wrappremios">
				<?php
					  if (isset($_GET["recompensas"]))
				  {
				  	$cnpj = $_GET["recompensas"];
				    $usuario->cnpjRest($cnpj);
				  }
				  else
				  {
				  	return false;
				  }
				  ?>
			</div>
			<div class="listaPremios">
				<?php
					  if (isset($_GET["recompensas"]))
				  {
				  	$cnpj = $_GET["recompensas"];
				    $usuario->cnpjRecompensa($cnpj);
				  }
				  else
				  {
				  	return false;
				  }
				?>
			</div>
		</div>
	</div>
			<?php 
			require_once('assets/footer.php');
		?>
	</main>
	<script type="text/javascript">
		$(document).ready(function() {
  			$(".msgalert").fadeIn(150);
  			$(".msgalert").delay(1000).fadeOut(1000);
		});
	</script>
</body>
</html>