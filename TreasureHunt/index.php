<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="TreasureHunt, um Jogo de Caça ao Tesouro de Segurança Computacional">
    <meta name="keywords" content="TreasureHunt, Treasure Hunt, Segurança Computacional, Cibersegurança, Cybersecurity, Computer Security">
    <meta name="author" content="Ricardo de la Rocha Ladeira">
    <title>TreasureHunt{Security} -- Um jogo para testar suas habilidades em Segurança Computacional!</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <link rel="icon" type="image/png" href="img/favicon.png">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <script src="js/efeitos.js"></script>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js"></script>
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <![endif]-->
</head>

<!-- class="text-light bg-dark" -->

<body>
    <input type="checkbox" name="contrast-mode" id="contrast">
    <div id="page-wrapper">
        <input type="radio" name="nav" id="inicio" checked tabindex="-1" class="tab">
        <input type="radio" name="nav" id="regras" tabindex="-1" class="tab">
        <input type="radio" name="nav" id="contato" tabindex="-1" class="tab">
        <!-- justify-content-center  -->
        <nav class="navbar navbar-expand-sm navbar-dark justify-content-center ">
            <input type="checkbox" name="collapse-btn" id="collapse-btn" role="button">
            <label for="collapse-btn" class="navbar-toggler"><span class="navbar-toggler-icon"></span></label>
            <div class="navbar-collapse collapse justify-content-center" id="collapsibleNavbar">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item"><label id="inicio-label" class="label-link" for="inicio" tabindex="0" role="link" accesskey="i">Início</label></li>
                    <li class="nav-item"><label id="regras-label" class="label-link" for="regras" tabindex="0" role="link" accesskey="j">Como Jogar?</label></li>
                    <li class="nav-item"><label id="contato-label" class="label-link" for="contato" tabindex="0" role="link" accesskey="c">Contato</label></li>
                </ul>
                <ul class="navbar-nav ml-auto">
                    <li>
                        <label for="contrast" class="form-inline justify-content-end label-link contrast-label" tabindex="0" title="Recurso de alto contraste" role="button" accesskey="a">
                            <span class="material-icons" aria-hidden="true">invert_colors</span>
                            <span class="sr-only">Recurso de alto Contraste</span>
                        </label>
                    </li>
                </ul>
            </div>

        </nav>
        <div id="main">
            <div class="jumbotron bg-dark" id="jumbotron-index">
                <h1 class="font-weight-bold" id="titulo-index" lang="en">
                    TreasureHunt<span id="espaco"> </span><span class="destaque">{</span>Security<span class="destaque">}</span>
                </h1>
                <h2 id="subtitulo-index">Um jogo para testar suas habilidades em Segurança Computacional. <span class="smile destaque"></span></h2>
            </div>
            <form action="acesso.php" method="POST" class="form-signin">
                <label>Autentique-se:</label>
                <label for="usuario" class="sr-only">Informe seu ID</label>
                <input type="number" min="1" name="usuario" id="usuario" class="form-control input-sm" placeholder="Informe seu ID" required autofocus data-toggle="tooltip" data-placement="bottom" title="Credencial numérica atribuída a você.">
                <label for="senha" class="sr-only">Informe sua senha</label>
                <input type="password" id="senha" name="senha" class="form-control" placeholder="Informe sua senha" required data-toggle="tooltip" data-placement="bottom" title="Senha fornecida junto à credencial.">
                <!--<input type="checkbox" value="lembrar-me" id="lembrar-me"><label for="lembrar-me">Lembrar-me</label>-->
                <button class="btn btn-dark btn-block" type="submit" name="enviar">Entrar</button>
                <?php
                if (isset($_GET['message'])) {
                    switch ($_GET['message']) {
                        case 'passwd_error':
                            echo '<div class="alert alert-danger login" role="alert"> Senha incorreta ou não informada!</div>';
                            break;
                        case 'user_error':
                            echo '<div class="alert alert-danger login" role="alert"> Usuário incorreto ou não informado!</div>';
                            break;
                    }
                }
                ?>
            </form>
        </div>
        <div id="como-jogar">
            <div class="jumbotron bg-dark">
                <h2 class="font-weight-bold page-title">Como Jogar<span class="destaque">?</span></h2>
            </div>
            <ul id="lista-de-regras">
                <li><span class="prompt"></span> Na tela de início, insira seu ID e sua senha e clique em
                    <button class="btn btn-sm btn-dark" name="enviar">Entrar</button>.
                </li>
                <li><span class="prompt"></span> Baixe e descompacte o arquivo zip disponível (sugestão: <code id="unzip"> unzip JogadorX.zip</code>, onde <code>X</code> é o seu ID). Este arquivo contém diretórios representados por números inteiros. Cada diretório contém pelo menos um arquivo.
                </li>
                <li><span class="prompt"></span> Seu objetivo é descobrir a palavra secreta (<i lang="en">flag</i>) escondida em cada um dos diretórios.
                </li>
                <li><span class="prompt"></span> Vencerá o jogo aquele que submeter mais respostas corretas em menos tempo, ou seja, o ranqueamento é feito pelo número de acertos e, em caso de empate, ficará à frente aquele que obteve seu último acerto antes.
                </li>
                <li><span class="prompt"></span> Cada <i lang="en">flag</i> descoberta é um desafio resolvido! Você só precisa realizar a submissão no sistema, informando o ID do problema (número do diretório) e a <i lang="en">flag</i> encontrada. O sistema informará se a <i lang="en">flag</i> está (in)correta.
                </li>
                <li><span class="prompt"></span> As <i lang="en">flags</i> possuem o formato <code> <span>TreasureHunt</span>{texto-aleatorio}</code>. Na submissão, digite toda <i lang="en">flag</i>! Exemplo: <code> <span lang="en">TreasureHunt</span>{dhi2uh39}</code>.
                </li>
            </ul>
        </div>
        <div id="contatos">
            <div class="jumbotron bg-dark">
                <h2 class="font-weight-bold page-title">Contato<span class="destaque">!</span></h2>
                <h3>Interessados em fazer parte da equipe são sempre bem-vindos e podem entrar em contato. <span class="smile destaque"></span></h3>
            </div>
            <address>

                <span class="address-title">Equipe atual:</span>
                <span class="contato">
                    <span class="nome-autor">Ricardo de la Rocha Ladeira</span>:
                    <span class="sinal-menor sinal-maior">ricardo.ladeira<span class="at font-weight-bold"></span>ifc.edu.br</span>
                </span>
                <span class="contato">
                    <span class="nome-autor">Vítor Augusto Ueno Otto</span>:
                    <span class="sinal-menor sinal-maior">vitoruenootto<span class="at font-weight-bold"></span>gmail.com</span>
                </span>

                <span class="address-title">Contribuidores:</span>
                <span class="contato nome-contrib">Henrique Arnicheski Dalposso</span>
                <span class="contato nome-contrib">Rafael Rodrigues Obelheiro</span>
                <span class="contato nome-contrib">Richard Robert Dias Custódio</span>
                <span class="contato nome-contrib">Vinícius Manuel Martins</span>

            </address>
        </div>
        <footer class="page-footer font-small">
            <div class="footer-copyright">
                <a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/" id="creative-commons">
                    <img alt="Licença Creative Commons" src="https://i.creativecommons.org/l/by-nc/4.0/80x15.png">
                </a>
                <br>
                <p>Esta obra está licenciada com uma Licença <a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/"><span lang="en">Creative Commons</span> Atribuição-NãoComercial 4.0 Internacional</a>.</p>
                <p><span lang="en">©</span> 2017-2020</p>
            </div>
        </footer>

    </div>
</body>

</html>