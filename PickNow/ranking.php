<?php
  require_once("assets/header.php");
   if ( !isset($_SESSION["login"] ) )
    {
        Header("Location:login.php");
    }
?>
<nav class="infobar">
	<nav class="wrapicons">
		<a href="index.php"><i class='fas fa-chevron-left'></i></a>
		<p class="nmrestaurante">Ranking</p>
	</nav>
</nav>
</div>
	<?php 
			require_once('assets/footer.php');
		?>
</main>
</body>
</html>