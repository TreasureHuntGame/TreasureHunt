<?php
require_once 'conexao.php';

ob_start();
@session_start();

if (!isset($_SESSION['usuario']) == true) {
	unset($_SESSION['usuario']);
	header('location:index.php');
}
?>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="description" content="TreasureHunt, um Jogo de Caça ao Tesouro de Segurança Computacional">
	<meta name="keywords" content="Treasure Hunt, Segurança Computacional">
	<meta name="author" content="Ricardo de la Rocha Ladeira">
	<meta http-equiv="refresh" content="20">
	<title>TreasureHunt{Home} -- You'll never find me!</title>
	<link rel="stylesheet" type="text/css" href="css/style.css">
	<link rel="icon" type="image/png" href="img/favicon.png">
	<script src="js/script.js"></script>
</head>
<body>
<h1>Pla<span class="destaque">car</span>{<span>!</span>}</h1>
<div id="modal-placar-content">
	<table>
		<tr>
			<th>Colocação</th>
			<th>Jogador (ID)</th>
			<th>Acertos</th>
			<th>Hora do Último Acerto</th>
		</tr>
<?php
	$stmt = $conexao->query("SELECT idUser, SUM(acertou) AS acertos, MAX(hora) AS hora FROM TreasureHunt.Resposta GROUP BY idUser ORDER BY acertos DESC, hora ASC");
	$i=0;
	while ($linha = $stmt->fetch(PDO::FETCH_OBJ)) {
		?>
				<tr>
					<td><?php echo ++$i."º"; ?></td>
					<td><?php echo $linha->idUser; ?></td>
					<td><?php echo $linha->acertos; ?></td>
					<td><?php echo $linha->hora; ?></td>
				</tr>
<?php
	}

?>
	</table>
</div>

</body>
</html>