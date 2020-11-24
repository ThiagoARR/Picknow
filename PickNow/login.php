<?php
  require_once('config.php');
?>
<!DOCTYPE html>
<html>
<head>
	<title></title>
</head>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
<link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<link rel="stylesheet" href="estilo.css">
<script type="text/javascript" src="script.js"></script>
<body>
	<main class="wraper">
		<section class="logocont">
			<picture class="logowrap">
				<img class="logopick" src="picknowlogo.png" width="200px">	
			</picture>
		</section>
		<section class="logincont">
			<form class="formlogin" action="logar.php" method="POST">
				<div class="user">
					Usuario<br>
					<input type="text" name="login" required><br>
				</div>
				<div class="senha">
					Senha<br>	
					<input type="password" name="senha" required><br>
				</div>

				<button class="btnlogin" type="submit">Entrar</button>
				<a href="cadastro.php"><div class="btnGoogle">Cria Conta</div></a>
				<?php
			if (isset($_GET['success']) && $_GET['success'] == '1') 
			{
					echo "<div class='msgalert 1'>Conta criada com sucesso</div>";
			}
			?>
			</form>
		</section>
	</main>
</body>
<script type="text/javascript">
$(".msgalert").fadeIn(150);
$(".msgalert").delay(1000).fadeOut(1000);
</script>
</html>