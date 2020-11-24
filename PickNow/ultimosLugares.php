<?php
	require_once('assets/header.php');

	 if ( !isset($_SESSION["login"] ) )
    {
        Header("Location:login.php");
    }
?>
<nav class="infobar">
		<nav class="wrapicons">
			<a href="perfil.php"><i class='fas fa-chevron-left'></i></a>
			<p class="nmrestaurante">Histórico</p>
		</nav>
	</nav>
		<section class="lastplaces">
				<?php
					$usuario = new clsRestaurante();
					$usuario->restauranteVisitado();
				?>		
		</section>
	</div>
			<?php 
			require_once('assets/footer.php');
		?>
	</main>
</body>
<?php 
	$usuario = new clsRestaurante();
	$usuario->listarJsvisits();
?>
</html>