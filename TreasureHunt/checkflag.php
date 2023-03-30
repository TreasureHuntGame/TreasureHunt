<?php
// Codifica os caracteres
require_once 'conexao.php';

ob_start();
@session_start();

if (!isset($_SESSION['usuario']) == true) {
	unset($_SESSION['usuario']);
	header('location:index.php');
}

function console_log($data) {
	echo '<script>';
	echo 'console.log(' . json_encode($data) . ')';
	echo '</script>';
}

$problema = filter_input(INPUT_POST, 'problema');
$flagPura = filter_input(INPUT_POST, 'flag');
$flagSemEspaco = preg_replace('/\s/', '', $flagPura);
$flagSemEspaco = str_replace('\t', '', $flagSemEspaco);
$flagSemEspaco = str_replace('\n', '', $flagSemEspaco);
$flagSemEspaco = str_replace('\r', '', $flagSemEspaco);
$flagSemEspaco = str_replace('\0', '', $flagSemEspaco);
$flagSemEspaco = str_replace('\x0B', '', $flagSemEspaco);
$flagSemEspaco = str_replace('\\', '', $flagSemEspaco);

$usuario = $_SESSION['usuario'];


// Insere idUsuario, idResposta e flag na tabela submissão
$ip = $_SERVER['REMOTE_ADDR'];
//$sql = "INSERT INTO TreasureHunt.Submissao VALUES ($usuario, $problema, '$flagSemEspaco', '$ip', CURRENT_TIMESTAMP)";
$sql = "INSERT INTO TreasureHunt.Submissao VALUES (:usuario, :problema, :flag, :ip, CURRENT_TIMESTAMP)";
$stmt = $conexao->prepare($sql);
$stmt->bindParam(':usuario', $usuario, PDO::PARAM_INT);
$stmt->bindParam(':problema', $problema, PDO::PARAM_INT);
$stmt->bindParam(':flag', $flagSemEspaco, PDO::PARAM_STR);
$stmt->bindParam(':ip', $ip, PDO::PARAM_STR);
$stmt->execute();

// Verifica se o usuário já acertou a questão
//$sql = "SELECT * FROM TreasureHunt.Resposta WHERE idUsuario='$usuario' AND idProblema='$problema' AND acertou=true";
$sql = "SELECT * FROM TreasureHunt.Resposta WHERE idUsuario=:usuario AND idProblema=:problema AND acertou=true";
$stmt = $conexao->prepare($sql);
$stmt->bindParam(':usuario', $usuario, PDO::PARAM_STR);
$stmt->bindParam(':problema', $problema, PDO::PARAM_STR);
$stmt->execute();

// Se retornar resultado, usuário já havia respondido corretamente
if ($stmt->rowCount() > 0) { // "erro" (aviso): questão já acertada
	header('Location:home.php?message=duplicada&id=' . $problema);
	exit();
}
else {
	// Se acerta a resposta e depois segue informando,
	// informa se está certa ou errada, mas não incrementa
	// as tentativas.

	// Poderia informar quando a resposta correta já foi submetida
	// e o usuário segue submetendo para o mesmo problema

	//$sql = "SELECT resposta FROM TreasureHunt.Resposta WHERE idUsuario='$usuario' AND idProblema='$problema'";
	$sql = "SELECT resposta FROM TreasureHunt.Resposta WHERE idUsuario=:usuario AND idProblema=:problema";
	$stmt = $conexao->prepare($sql);
	$stmt->bindParam(':usuario', $usuario, PDO::PARAM_STR);
	$stmt->bindParam(':problema', $problema, PDO::PARAM_STR);
	// $stmt->bindParam(':flag', $flag, PDO::PARAM_STR); // não usamos mais o hash da flag digitada no select
	$stmt->execute();
	$resposta_hash = $stmt->fetch();

	// verifica a flag digitada com o hash da resposta armazenado no bd; se retornar true é a resposta correta
	if (password_verify($flagSemEspaco, $resposta_hash[0])) {
		$acertou = true;
		atualiza($acertou, $usuario, $problema);

		//$stmt = $conexao->prepare("SELECT COUNT(*) AS Total FROM TreasureHunt.Resposta WHERE idUsuario=$usuario");
		$stmt = $conexao->prepare("SELECT COUNT(*) AS Total FROM TreasureHunt.Resposta WHERE idUsuario=:usuario");
		$stmt->bindParam(':usuario', $usuario, PDO::PARAM_STR);
		$stmt->execute();
		$linhaTotal = $stmt->fetch(PDO::FETCH_OBJ);

		//$stmt = $conexao->prepare("SELECT COUNT(*) AS Acertos FROM TreasureHunt.Resposta WHERE idUsuario=$usuario and acertou=1");
		$stmt = $conexao->prepare("SELECT COUNT(*) AS Acertos FROM TreasureHunt.Resposta WHERE idUsuario=:usuario and acertou=1");
		$stmt->bindParam(':usuario', $usuario, PDO::PARAM_STR);
		$stmt->execute();
		$linhaAcertos = $stmt->fetch(PDO::FETCH_OBJ);
		// enviar mensagem de que usuário acertou questão (mostra na caixa verde)
		header('Location:home.php?message=acertou&acertos=' . $linhaAcertos->Acertos . '&total=' . $linhaTotal->Total);
		exit();
	} else { // se resposta não coincidir com hash do bd, resposta digitada é incorreta
		$stmt = $conexao->prepare("SELECT MAX(idProblema) AS Max FROM TreasureHunt.Resposta");
		$stmt->execute();
		$linhaTotal = $stmt->fetch(PDO::FETCH_OBJ);
		if ($problema < 1 or $problema > $linhaTotal->Max) { // erro: id inválido
			header('Location:home.php?message=id_invalido');
			exit();
		} else {
			$acertou = false;
			atualiza($acertou, $usuario, $problema);

			$tamanho = strlen($flagSemEspaco);
			$verificaPadrao = (substr($flagSemEspaco, 0, 13) === 'TreasureHunt{') && (substr($flagSemEspaco, $tamanho - 1, $tamanho) === '}');
			$mensagem = "Errou!";
			if ($verificaPadrao != 1) { // erro: flag no formato incorreto
				$mensagem .= " Considere submeter a flag no seguinte formato: TreasureHunt{texto-aleatorio}";
				header('Location:home.php?message=formato');
				exit();
			}
			header('Location:home.php?message=erro');
			exit();
		}
	}
}

/* Função que atualiza a tabela de respostas
   quando o usuário submeter uma flag */
function atualiza($resposta, $usuario, $problema) {
	include 'conexao.php';

	$param = "";

	if ($resposta == true) {
		$hora = date('Y-m-d H:i:s');
		$param = "acertou=1, hora='$hora',";
	}

	//$sql = "UPDATE TreasureHunt.Resposta SET $param tentativas=tentativas+1 WHERE idUsuario='$usuario' AND idProblema='$problema' AND acertou=0";
	$sql = "UPDATE TreasureHunt.Resposta SET $param tentativas=tentativas+1 WHERE idUsuario=:usuario AND idProblema=:problema AND acertou=0";
	$stmt = $conexao->prepare($sql);
	$stmt->bindParam(':usuario', $usuario, PDO::PARAM_STR);
	$stmt->bindParam(':problema', $problema, PDO::PARAM_STR);
	$stmt->execute();
}
?>
<script>
	window.setTimeout("location.href='home.php';");
</script>