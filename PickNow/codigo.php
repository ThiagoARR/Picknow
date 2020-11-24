<?php
  require_once("assets/header.php");
?>
		<section class="contentwrap">
			<div class="box">
			<form action="ativarcodigo.php" method="POST" class="wrapcod">
				<label for="cpf" class="cpf">Insira o CPF<br>
				<input id="cpf" name="cpf" type="text" tabindex="2"
                       required maxlength="11" /><br>
                <label for="cnpj" class="cpf">Insira o CNPJ<br>
				<input id="cnpj" name="cnpj" type="text" tabindex="2" 
                       maxlength="14" 
                       required /><br>
                <label for="valor" class="cpf">Valor da Compra<br>
                <input id="valor" class="codi" type="text" name="indice" required/><br>
                <button class="btnresgatar"type="submit">Creditar Pontos</button>
			</form>
			</div>
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

setInputFilter(document.getElementById("valor"), function(value) {
  return /^\d*[,]?\d{0,2}$/.test(value); });

setInputFilter(document.getElementById("cpf"), function(value) {
  return /^\d*$/.test(value); });

setInputFilter(document.getElementById("cnpj"), function(value) {
  return /^\d*$/.test(value); });
</script>
</html>