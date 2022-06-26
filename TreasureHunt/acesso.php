<?php
// Codifica os caracteres
//header("Content-type: text/html; charset=utf-8");
require_once 'conexao.php';

// filtrar input do id de usuário
$usuario = filter_input(INPUT_POST, 'usuario');
// "montar" comando sql, prepará-lo, inserir variáveis e executar
$sql = "SELECT * FROM Usuario where id='$usuario'";
$stmt = $conexao->prepare($sql);
$stmt->bindParam(':usuario', $usuario, PDO::PARAM_STR);
$stmt->execute();

// Se o select retorna algum usuario, verifica a senha
if ($stmt->rowCount() > 0) {
	// filtrar input da senha
	$senha = filter_input(INPUT_POST, 'senha');

	// pegar hash da senha desse usuário: usada na função password_verify comparando com a digitada
	$sql = "SELECT pass FROM Usuario where id='$usuario'";
	$stmt = $conexao->prepare($sql);
	$stmt->bindParam(':usuario', $usuario, PDO::PARAM_STR);
	$stmt->execute();
	$passwd_hash = $stmt->fetch();;

	// garante que não tem sessão ativa 
	@session_start();
	unset($_SESSION['usuario']);

	// Se a senha digitada bate com o hash (função password_verify), redireciona para a home do sistema 
	if (password_verify($senha, $passwd_hash[0])) {
		$ip = $_SERVER['REMOTE_ADDR'];
		$sql = "INSERT INTO TreasureHunt.Submissao VALUES ($usuario, 0, 'submissaoPadrao', '$ip', CURRENT_TIMESTAMP)";
		$stmt = $conexao->prepare($sql);
		$stmt->bindParam(':usuario', $usuario, PDO::PARAM_STR);
		$stmt->bindParam(':problema', $problema, PDO::PARAM_STR);
		$stmt->bindParam(':ip', $ip, PDO::PARAM_STR);
		$stmt->execute();
		// loga usuário e redireciona para home
		$_SESSION['usuario'] = $usuario;
		header('location:home.php');
	}
	else {
		header('Location:index.php?message=passwd_error'); // erro: senha incorreta
	}
}
else { // se o primeiro select não retornou usário é porque o id está incorreto
	header('Location:index.php?message=user_error');
}