<?php
// Codifica os caracteres
header("Content-type: text/html; charset=utf-8");
require_once 'conexao.php';

$usuario = filter_input(INPUT_POST, 'usuario');

$sql = "SELECT * FROM Usuario where id='$usuario'";

$stmt = $conexao->prepare($sql);
$stmt->bindParam(':usuario', $usuario, PDO::PARAM_STR);
$stmt->execute();

// Se existe o usuario, verifica a senha
if ($stmt->rowCount() > 0) {
	$senha = "";
	while ($linha = $stmt->fetch(PDO::FETCH_OBJ)) {
		$senha = hash("sha256", filter_input(INPUT_POST, 'senha').$linha->saltpass);
	}
	// Rever o bind com :
	$sql = "SELECT * FROM Usuario where id='$usuario' and pass='$senha'";
	$stmt = $conexao->prepare($sql);
	$stmt->bindParam(':senha', $senha, PDO::PARAM_STR);
	$stmt->execute();

	@session_start();
	unset($_SESSION['usuario']);

	// Se existe um usuario, redireciona para a home do sistema
	if ($stmt->rowCount() > 0) {
		$ip = $_SERVER['REMOTE_ADDR'];
		$sql = "INSERT INTO TreasureHunt.Submissao VALUES ($usuario, 0, 'submissaoPadrao', '$ip', CURRENT_TIMESTAMP)";
		$stmt = $conexao->prepare($sql);
		$stmt->bindParam(':usuario', $usuario, PDO::PARAM_STR);
		$stmt->bindParam(':problema', $problema, PDO::PARAM_STR);
		$stmt->bindParam(':ip', $ip, PDO::PARAM_STR);
		$stmt->execute();

		$_SESSION['usuario'] = $usuario;
		header('location:home.php');
	}
	else {
		header('Location:index.php?message=passwd_error');
	}
}
else {
	header('Location:index.php?message=user_error');
}
