<?php
require_once('assets/header.php');
	 if ( !isset($_SESSION["login"] ) )
    {
        Header("Location:login.php");
    }
?>  

		<section class="contentwrap">
			<div class="pontoscont">
				<?php
						$usuario = new clsCliente();
						$usuario->pontoCliente();
				?>
				<p class="nomeponto">PONTOS</p>
			</div>
			<div class="wrappic">
				<picture>
					<?php
						$usuario = new clsCliente();
						$usuario->imgIndexCliente();
					?>
				</picture>
				<?php
						$usuario = new clsCliente();
						$usuario->infoCliente2();
				?>
			</div>
			<div class="visitados">
				<ul class="menuperfil">
					<a href="lugaresFavoritos.php"><li class="itemlist first"><i class="fas fa-star mgri"></i>Lugares Favoritos</li></a>
					<a href="ultimosLugares.php"><li class="itemlist"><i class="fas fa-history mgri"></i>Histórico</li></a>
					<a href="cupom.php"><li class="itemlist"><i class="fas fa-bell mgri"></i>Meus Cupoms</li></a>
					<a href="configurar.php"><li class="itemlist"><i class="fas fa-cog mgri"></i>Configurações</li></a>
					<a href="help.php"><li class="itemlist"><i class="fas fa-question-circle mgri"></i>Ajuda</li></a>
					<a href="sair.php"><li class="itemlist"><i class="fas fa-sign-out-alt mgri"></i>Sair</li></a>
				</ul>
			</div>
		</section>
	</div>
		<?php 
			require_once('assets/footer.php');
		?>
	</main>
</body>
</html>