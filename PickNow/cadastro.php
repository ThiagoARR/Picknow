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
			<form class="formlogin" action="registrar.php" method="POST">
				<div class="user">
					Nome<br>
					<input type="text" name="nome" required><br>
				</div>
				<div class="senha">
					E-mail<br>
					<input type="text" name="email" required><br>
				</div>
				<div class="senha">
					Senha<br>	
					<input type="password" name="senha" required><br>
				</div>
				<div class="senha">
					Cpf<br>
					<input type="text" name="cpf" id="cpff" required maxlength="11" minlength="11"><br>
				</div>

				<button class="btnlogin" type="submit">Cadastrar</button>
				<a href="login.php"><div class="btnGoogle">Entrar</div></a>
			</form>
			<?php
			if (isset($_GET['erro']) && $_GET['erro'] == '1') 
			{
					echo "<div class='msgalert 1'>O Cpf ja está sendo utilizado</div>";
			}
			?>
		</section>
	</main>
</body>
<script type="text/javascript">
	function setInputFilter(textbox, inputFilter) {
  ["input", "keydown", "keyup", "mousedown", "mouseup", "select", "contextmenu", "drop"].forEach(function(event) {
    textbox.addEventListener(event, function() {
      if (inputFilter(this.value)) {
        this.oldValue = this.value;
        this.oldSelectionStart = this.selectionStart;
        this.oldSelectionEnd = this.selectionEnd;
      } else if (this.hasOwnProperty("oldValue")) {
        this.value = this.oldValue;
        this.setSelectionRange(this.oldSelectionStart, this.oldSelectionEnd);
      }
    });
  });
}

setInputFilter(document.getElementById("cpff"), function(value) {
  return /^\d*$/.test(value); });

$(".msgalert").fadeIn(150);
$(".msgalert").delay(1000).fadeOut(1000);
</script>
</html>