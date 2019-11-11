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
<html lang="pt-br">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="TreasureHunt, um Jogo de Caça ao Tesouro de Segurança Computacional">
    <meta name="keywords" content="TreasureHunt, Treasure Hunt, Segurança Computacional, Cibersegurança, Cybersecurity, Computer Security">
    <meta name="author" content="Ricardo de la Rocha Ladeira">
    <title>TreasureHunt{Security} -- You'll never find me!</title>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <link rel="icon" type="image/png" href="img/favicon.png">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <script src="js/efeitos-0.1.js"></script>
</head>
<body class="text-light bg-dark">
    <h1 class="font-weight-bold">Pla<span class="destaque">car</span>{<span>!</span>}</h1>
        <div id="modal-placar-content">
            <table>
                <tr>
                    <th>Colocação</th>
                    <th>Jogador (ID)</th>
                    <th>Acertos</th>
                    <th>Hora do Último Acerto</th>
                </tr>
                <?php
	$stmt = $conexao->query("SELECT idUsuario, SUM(acertou) AS acertos, MAX(hora) AS hora FROM TreasureHunt.Resposta GROUP BY idUsuario ORDER BY acertos DESC, hora ASC, idUsuario ASC");
	$i=0;
	while ($linha = $stmt->fetch(PDO::FETCH_OBJ)) {
		?>
                    <tr>
                        <td>
                            <?php echo ++$i."º"; ?>
                        </td>
                        <td>
                            <?php echo $linha->idUsuario; ?>
                        </td>
                        <td>
                            <?php echo $linha->acertos; ?>
                        </td>
                        <td>
                            <?php echo $linha->hora; ?>
                        </td>
                    </tr>
                    <?php
	}
?>
            </table>
        </div>
    </body>
    </html>