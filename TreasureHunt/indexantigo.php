<!DOCTYPE html>
<html lang="pt-br">
<head>
	<meta charset="utf-8">
	<meta name="description" content="TreasureHunt, um Jogo de Caça ao Tesouro de Segurança Computacional">
	<meta name="keywords" content="Treasure Hunt, Segurança Computacional">
	<meta name="author" content="Ricardo de la Rocha Ladeira">
	<title>TreasureHunt{Security} -- You'll never find me!</title>
	<link rel="stylesheet" type="text/css" href="css/style.css">
	<link rel="icon" type="image/png" href="img/favicon.png">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script>
$(document).ready(function(){
	$("#regras").mouseenter(function(){
		$("#main").css("display", "none");
    });
    $("#regras").mouseleave(function(){
    	$("#main").css("display", "block");
    });
});		
	</script>
</head>
<body>
<div id="container">
    <nav>
        <ul>
            <li><a>Início</a></li>
            <li><a id="regras">Como Jogar?</a>
            <li><a id="contato">Contato</a></li>
        </ul>
    </nav>
    <div id="main">
	  	<h1>Treasure<span id="bracket">Hunt</span>{<span>Security</span>}</h1>
		<p>Um jogo para testar suas habilidades em Segurança Computacional. <span id="smile">:)</span></p>
		<form action="acesso.php" method="POST">
			<label>Autentique-se:</label><br>
	    	<input type="text" name="usuario" placeholder="Informe seu ID" required autofocus><br>
	        <input type="password" name="senha" placeholder="Informe sua senha" required><br>
	        <button type="submit" name="enviar"><span id="whitebracket">{</span>Entrar<span id="whitebracket">}</span></button>
	    </form>
	</div>
    <div id="modal-regras">
    	<h1>Como <span class="destaque">Jogar</span>{<span>?</span>}</h1>
    	<div id="modal-regras-content">
    		<ul id="lista-de-regras">
	    		<li>
	    			Na tela de início, insira seu ID e sua senha e clique em <button><span id="whitebracket">{</span>Entrar<span id="whitebracket">}</span></button>.
	    		</li>
	    		<li>
	    			Baixe o arquivo zip disponível e descompacte-o (sugestão: <code>unzip JogadorX.zip</code>, onde <code>X</code> é o seu ID). Este arquivo contém diretórios representados por números inteiros. Cada diretório contém pelo menos um arquivo.
	    		</li>
	    		<li>
	    			Seu objetivo é descobrir a palavra secreta (flag) escondida em cada um dos diretórios.
	    		</li>
	    		<li>
	    			Cada palavra descoberta é um desafio resolvido! Você só precisa realizar a submissão no sistema, informando o ID do problema (número do diretório) e a flag encontrada. O sistema informará se a flag está (in)correta.
	    		</li>
	    		<li>
	    			As flags possuem o formato <strong>TreasureHunt{texto-aleatorio}</strong>. Na submissão, digite toda flag! Exemplo: TreasureHunt{dhi2uh39}.
	    		</li>
	    	</ul>
    	</div>
    </div>
    <div id="modal-contato">
    	<h1>Cont<span class="destaque">@</span>te-<span class="destaque">nos</span>{<span>!</span>}</h1>
    	<address>
    	<a href="https://instagram.com/ricardo.delarocha"><span class="nome">Ricardo de la Rocha <span class="destaque">Ladeira</span></span></a> <span class="sinal-menor"></span>ricardo.delarocha<span class="at"></span>gmail.com<span class="sinal-maior"></span><br>
    	<span class="nome">Rafael Rodrigues <span class="destaque">Obelheiro</span></span> <span class="sinal-menor"></span>rafael.obelheiro<span class="at"></span>udesc.br<span class="sinal-maior"></span>
    	</address>
    </div>
</div>
<script src="js/script.js"></script>	
</body>
</html>