<?php
  require_once("assets/header.php");
   if ( !isset($_SESSION["login"] ) )
    {
        Header("Location:login.php");
    }
?>
<nav class="infobar">
	<nav class="wrapicons">
		<a href="perfil.php"><i class='fas fa-chevron-left'></i></a>
		<p class="nmrestaurante">Favoritos</p>
	</nav>
</nav>
<section class="favoritos">
	<?php
		$usuario = new clsRestaurante();
		$usuario->listarFavorito();
	?>
</section>
</div>
	<?php 
			require_once('assets/footer.php');
		?>
</main>
</body>
</html>