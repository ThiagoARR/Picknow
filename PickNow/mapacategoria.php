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
		</nav>
	</nav>
	<div id="mapc"></div>
	</div>
	</main>
	<?php
    	 echo "<script>";
         echo "var customLabel = {";
         echo "restaurant: {";
         echo "label: 'R'";
         echo "},";
         echo "bar: {";
         echo "label: 'B'";
         echo "}";
         echo "};";
         echo "";
         echo "function initMap() {";
    	 $usuario->mapacategP();
         echo "}";
         echo "</script>";	
	?>
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDwQCmeZXaCrFiivFCxDPMUKIfo98D89Vk&callback=initMap">
    </script>
    </body>
</html>