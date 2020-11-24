<?php
require_once('assets/header.php');
$usuario = new clsPratos();
	 if ( !isset($_SESSION["login"] ) )
    {
        Header("Location:login.php");
    }
?>  
<nav class="infobar">
		<nav class="wrapicons">
			<?php
			echo "<a href='".$_SERVER['HTTP_REFERER']."'><i class='fas fa-chevron-left'></i></a>";
			if (isset($_GET["prato"]))
				  {
				  	$prato = $_GET["prato"];
				  	$usuario->codigoPratoRestaurante($prato);
				  }
				  else
				  {
				  	return false;
				  }
			?>

		</nav>
</nav>
<?php

	if (isset($_GET["prato"]))
				  {
				  	$prato = $_GET["prato"];
				  	$usuario->codigoPrato($prato);
				  }
				  else
				  {
				  	return false;
				  }
?>
</div>
	<?php 
			require_once('assets/footer.php');
		?>
	</main>
</body>
</html>