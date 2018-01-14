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
	<title>TreasureHunt{Home} -- You'll never find me!</title>
	<link rel="stylesheet" type="text/css" href="css/style.css">
	<link rel="icon" type="image/png" href="img/favicon.png">
	<script src="js/script.js"></script>
</head>
<body>
<div id="container">
    <nav>
        <ul>
            <li><a>Principal</a></li>
            <li><a id="placar">Placar</a>
            <li><a id="regras">Como Jogar?</a>
            <li><a id="contato">Contato</a></li>
            <li><a id="logout" href="logout.php">Logout</a></li>
        </ul>
    </nav>
    <div id="main">
	  	<h1>Prin<span class="destaque">cipal</span>{<span>!</span>}</h1>
	  	<h2>Prob<span class="destaque">lemas</span>{<span>!</span>}</h2>
	  	<label>Seu ID:</label> <span><?php $usuario=$_SESSION['usuario']; echo $usuario ?></span><br>
	  	<label>Seu arquivo:</label> <a href="<?php print_r("Desafios/Jogador".$usuario.".zip") ?>"><?php print_r("Jogador".$usuario.".zip") ?></a>
	  	<h2>Submeta sua <span class="destaque">palavra secreta</span>{<span>!</span>}</h2>
	  	<form id="interno" action="checkflag.php" method="POST">
	  		<input type="text" name="problema" placeholder="Informe o ID do problema" required autofocus><br>
	        <input id="flag-interno" type="text" name="flag" placeholder="Informe a palavra secreta" required><br>
	        <button type="submit" name="enviar"><span id="whitebracket">{</span>Enviar<span id="whitebracket">}</span></button>
	  	</form>
	  	<div id="modal-placar-content">
	<table>
		<tr>
			<th>Problema</th>
			<th>Status</th>
			<th>Nº de Tentativas</th>
		</tr>
<?php
	$usuario = $_SESSION['usuario'];
	$stmt = $conexao->query("SELECT idProblema, acertou, tentativas FROM TreasureHunt.Resposta WHERE idUser='$usuario'");
	$i=0;
	while ($linha = $stmt->fetch(PDO::FETCH_OBJ)) {
		?>
				<tr>
					<td><?php echo $linha->idProblema; ?></td>
					<td>
						<?php
						if ($linha->acertou > 0) {
							echo "Resolvido";
						}
						else {
							echo "Não Resolvido";
						}
						?>
					</td>
					<td><?php echo $linha->tentativas; ?></td>
				</tr>
<?php
	}
?>
	</table>
</div>
	</div>
	<div id="modal-placar">
		<iframe src="placar.php" width="100%" height="72%" id="placar"></iframe>
	</div>
    <div id="modal-regras">
    	<h1>Como <span class="destaque">Jogar</span>{<span>?</span>}</h1>
    	<div id="modal-regras-content">
	    	<p>Na tela de início, insira seu ID e sua senha e clique em <button><span id="whitebracket">{</span>Entrar<span id="whitebracket">}</span></button>.</p>
	    	<p>Faça o download do arquivo zip disponível e descompacte-o. Este arquivo contém alguns diretórios representados por números inteiros. Cada diretório contém pelo menos um arquivo.</p>
	    	<p>Seu objetivo é descobrir a palavra secreta escondida em cada um dos diretórios.</p>
	    	<p>Cada palavra descoberta é um desafio resolvido! Você só precisa realizar a submissão no sistema, informando o ID do problema (número do diretório) e a palavra encontrada. O sistema informará se a palavra está (in)correta.</p>
	    	<p>As palavras secretas possuem o formato <strong>TreasureHunt{texto-aleatorio}</strong>. Na submissão, digite toda palavra! Exemplo: TreasureHunt{dhi2uh39}.</p>
    	</div>
    </div>
    <div id="modal-contato">
    	<h1>Cont<span class="destaque">@</span>te-<span class="destaque">nos</span>{<span>!</span>}</h1>
    	<address>
    	<span class="nome">Ricardo de la Rocha <span class="destaque">Ladeira</span></span> <span class="sinal-menor"></span>ricardo.delarocha<span class="at"></span>gmail.com<span class="sinal-maior"></span><br>
    	<span class="nome">Rafael Rodrigues <span class="destaque">Obelheiro</span></span> <span class="sinal-menor"></span>rafael.obelheiro<span class="at"></span>udesc.br<span class="sinal-maior"></span>
    	</address>
    </div>
    <div id="modal-logout">
    	<h1>Clique em <span class="destaque">Logout</span> e saia do <span class="destaque">Jogo</span>{<span>!</span>}</h1>
    </div>
</div>
</body>
</html>