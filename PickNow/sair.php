<?php 
	session_start();
	session_destroy("login");
	Header("Location:login.php");
 ?>