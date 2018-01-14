<?php
require_once 'conexao.php';

ob_start();
@session_start();

unset($_SESSION['usuario']);
header('location:index.php');
?>