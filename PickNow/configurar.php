<?php
require_once('assets/header.php');
	 if ( !isset($_SESSION["login"] ) )
    {
        Header("Location:login.php");
    }
?>  

		<section class="contentwrapconfig">
			<div class="wrappicconfig">
				<picture>
					<?php
						$usuario = new clsCliente();
						$usuario->imgIndexCliente();
					?>
				</picture>
			</div>

			<form class="formconfig">
				<div class="userconfig">
					Nome<br>
					<?php
						$usuario = new clsCliente();
						$usuario->nmCliente();
					?>
				</div>
				<div class="senhaconfig">
					Senha atual<br>	
					<input type="password" name="senha" required><br>
				</div>
				<div class="senhaconfig">
					Nova Senha<br>	
					<input type="password" name="novasenha" required><br>
				</div>
				<div class="emailconfig">
					E-mail<br>	
					<?php
						$usuario = new clsCliente();
						$usuario->emailCliente();
					?>
				</div>
			</form>
			<div class="editinfo"><p class="edit">Editar informações</p><p class="altpass">Alterar Senha</p></div>
			<div class="savealt"><p>Salvar Alterações</p></div>
		</section>
	</div>
		<?php 
			require_once('assets/footer.php');
		?>
	</main>
</body>
<script type="text/javascript">
	$(".altpass").click(function(){
		$('.senhaconfig').show();			
	});
</script>
</html>