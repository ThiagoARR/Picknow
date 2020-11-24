<?php
	require_once('assets/header.php');

	 if ( !isset($_SESSION["login"] ) )
    {
        Header("Location:login.php");
    }
?>  
		<section class="contentwrap">
			<form class="formcodigo" action="resgatar.php" method="POST">
				<div class="wrapcodigo">
	                <label for="codigo" class="textcodigo">Adicionar Código<br>
	                <input id="codigo" class="codigo" type="text" name="codigo">
					<br>
	                <button type="submit" class="btnresgatar">Resgatar Codigo</button>
	                <p>
	                	<?php
							if (isset($_GET['validar']) && $_GET['validar'] == '1') 
							{
	   							echo "Código Válido";
							}
							else
								if (isset($_GET['validar']) && $_GET['validar'] == '2') 
								{
									echo "Código Inválido";
								}
						?>
					</p>
            	</div>
			</form>
		</section>
	</main>
</body>
</html>