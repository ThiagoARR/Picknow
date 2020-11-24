<?php
	require_once("assets/header.php");
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
			<p class="nmrestaurante">Mapa</p>
			<span id="cord"></span>
			<span id="cord2"></span>
		</nav>
	</nav>
	<div id="map">
	</div>
	</div>
	<?php 
			require_once('assets/footer.php');
		?>
	</main>
		<?php
			if (isset($_GET["local"]))
			{
			 	$local = $_GET["local"];
			 	$usuario->loc($local);
			} 
		?>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDwQCmeZXaCrFiivFCxDPMUKIfo98D89Vk&callback=getLocation"
    async defer></script>
 	</script>   
    </body>
</html>