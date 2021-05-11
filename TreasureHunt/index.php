<?php
header('Content-Type: text/html; charset=utf-8');
?>
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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

    <link rel="icon" type="image/png" href="img/favicon.png">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <script src="js/efeitos.js"></script>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <!-- <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"> -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <![endif]-->

</head>

<body>
    <input type="checkbox" name="contrast-mode" id="contrast">
    <div id="page-wrapper">
        <input type="radio" name="nav" id="inicio" checked tabindex="-1" class="tab">
        <input type="radio" name="nav" id="regras" tabindex="-1" class="tab">
        <input type="radio" name="nav" id="contato" tabindex="-1" class="tab">
        <noscript>
            <div class="jumbotron bg-dark col">
                <p>Javascript desabilitado! Algumas funcionalidades podem apresentar limitações.</p>
            </div>
        </noscript>
        <nav class="navbar navbar-expand-sm navbar-dark justify-content-center">
            <input type="checkbox" name="collapse-btn" id="collapse-btn" role="button">
            <label for="collapse-btn" class="navbar-toggler"><span class="navbar-toggler-icon"><span class="sr-only">Expandir menu de navegação</span></span></label>
            <div class="navbar-collapse collapse justify-content-center" id="collapsibleNavbar">
                <ul class="navbar-nav mx-auto">
                    <li class="nav-item"><label id="inicio-label" class="label-link" for="inicio" tabindex="0" accesskey="i">Início</label></li>
                    <li class="nav-item"><label id="regras-label" class="label-link" for="regras" tabindex="0" accesskey="j">Como Jogar?</label></li>
                    <li class="nav-item"><label id="contato-label" class="label-link" for="contato" tabindex="0" accesskey="c">Contato</label></li>
                </ul>
            </div>
            <ul class="navbar-nav ml-auto" id="contrast-container" role="presentation">
                <li>
                    <label for="contrast" id="contrast-label" class="form-inline justify-content-end label-link contrast-label" tabindex="0" data-toggle="tooltip" data-trigger="hover" data-placement="bottom" title="Recurso de alto contraste" accesskey="a">
                        <span class="material-icons" aria-hidden="true">invert_colors</span>
                        <span class="sr-only">Botão para ativar Recurso de alto Contraste</span>
                    </label>
                </li>
            </ul>
        </nav>
        <div id="main">
            <div class="jumbotron bg-dark" id="jumbotron-index">
                <h1 class="font-weight-bold" id="titulo-index" lang="en">
                    TreasureHunt<span id="espaco"> </span><span class="destaque chaves-left" aria-hidden="true"></span>Security<span class="destaque chaves-right" aria-hidden="true"></span>
                </h1>
                <h2 id="subtitulo-index">Um jogo para testar suas habilidades em Segurança Computacional. <span class="smile destaque" aria-hidden="true"></span></h2>
            </div>
            <form action="acesso.php" method="POST" class="form-signin">
                <label>Autentique-se:</label>
                <label for="usuario" class="sr-only">Informe seu ID</label>
                <input type="number" min="1" name="usuario" id="usuario" class="form-control input-sm" placeholder="Informe seu ID" required autofocus data-trigger="hover" data-toggle="tooltip" data-placement="top" title="Credencial numérica atribuída a você.">
                <label for="senha" class="sr-only">Informe sua senha</label>
                <input type="password" id="senha" name="senha" class="form-control" placeholder="Informe sua senha" data-trigger="hover" data-toggle="tooltip" data-placement="top" title="Senha fornecida junto à credencial." required>
                <!--<input type="checkbox" value="lembrar-me" id="lembrar-me"><label for="lembrar-me">Lembrar-me</label>-->
                <button class="btn btn-dark btn-block" type="submit" name="enviar">Entrar</button>
                <?php
                if (isset($_GET['message'])) {
                    switch ($_GET['message']) {
                        case 'passwd_error':
                            echo '<div class="alert alert-danger login" role="alert"> Senha incorreta ou não informada! Verifique se a senha não foi alterada recentemente e se as teclas Caps Lock e Num Lock estão ativadas.</div>';
                            break;
                        case 'user_error':
                            echo '<div class="alert alert-danger login" role="alert"> Usuário incorreto ou não informado! Verifique se o identificador foi digitado corretamente.</div>';
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
                <li><span class="prompt"></span> Seu objetivo é descobrir a palavra secreta (<em lang="en">flag</em>) escondida em cada um dos diretórios.
                </li>
                <li><span class="prompt"></span> Vencerá o jogo aquele que submeter mais respostas corretas em menos tempo, ou seja, o ranqueamento é feito pelo número de acertos e, em caso de empate, ficará à frente aquele que obteve seu último acerto antes.
                </li>
                <li><span class="prompt"></span> Cada <em lang="en">flag</em> descoberta é um desafio resolvido! Você só precisa realizar a submissão no sistema, informando o ID do problema (número do diretório) e a <em lang="en">flag</em> encontrada. O sistema informará se a <em lang="en">flag</em> está (in)correta.
                </li>
                <li><span class="prompt"></span> As <em lang="en">flags</em> possuem o formato <code> <span>TreasureHunt</span>{texto-aleatorio}</code>. Na submissão, digite toda <em lang="en">flag</em>! Exemplo: <code> <span lang="en">TreasureHunt</span>{dhi2uh39}</code>.
                </li>
            </ul>
        </div>
        <div id="contatos">
            <div class="jumbotron bg-dark">
                <h2 class="font-weight-bold page-title">Contato<span class="destaque">!</span></h2>
                <h3>Interessados em fazer parte da equipe são sempre bem-vindos e podem entrar em contato. <span class="smile destaque" aria-hidden="true"></span></h3>
            </div>
            <address>

                <span class="address-title">Equipe atual:</span>
                <span class="contato">
                    <span class="nome-autor">Ricardo de la Rocha Ladeira</span>:
                    <span><span class="sinal-menor" aria-hidden="true"></span>ricardo.ladeira<span class="at font-weight-bold"></span>ifc.edu.br<span class="sinal-maior" aria-hidden="true"></span></span>
                </span>
                <span class="contato">
                    <span class="nome-autor">Vítor Augusto Ueno Otto</span>:
                    <span><span class="sinal-menor" aria-hidden="true"></span>vitoruenootto<span class="at font-weight-bold"></span>gmail.com<span class="sinal-maior" aria-hidden="true"></span></span>
                </span>
                <span class="contato">
                    <span class="nome-autor">Lucas Vargas</span>:
                    <span><span class="sinal-menor" aria-hidden="true"></span>lucasvargas27<span class="at font-weight-bold"></span>hotmail.com<span class="sinal-maior" aria-hidden="true"></span></span>
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
                <a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/" id="creative-commons" target="_blank">
                    <img alt="Licença Creative Commons" src="https://i.creativecommons.org/l/by-nc/4.0/80x15.png">
                <br>
                <span>Esta obra está licenciada com uma Licença <span lang="en">Creative Commons</span> Atribuição-NãoComercial 4.0 Internacional</span> (Abre em nova janela).</a>
                <p><span lang="en">©</span> 2017-<?php echo date("Y");?></p>
            </div>
        </footer>

        <?php
        if (!(isset($_COOKIE['cookie_notice_accepted']))) {
            echo '<input type="checkbox" name="hide-cookie-bar" id="hide-cookie-bar">
            <div id="cookie-bar" class="navbar fixed-bottom container-fluid noscript">
            <div class="row mx-auto">
            <div class="col-lg-7 col-sm-12">
             <span>Nós usamos cookies para armazenar as preferências de contraste dos usuários.
             Ao clicar em "Sim", assumiremos que você está de acordo com isso. </span>
             </div>
             <div class="col-lg-5 col-sm-12 ml-auto">
             <label for="hide-cookie-bar">
             <a class="btn btn-primary" id="cookie-yes" tabindex="0" role="button">Sim</a>
             <a class="btn btn-primary" id="cookie-no" tabindex="0" role="button">Não</a>
             </label>
             <a href="#modal-privacy" id="open-modal-btn" class="btn btn-primary">Detalhes</a>
             </div>
             </div>
             </div>';

            echo '<div id="modal-privacy" class="overlay noscript" role="dialog" tabindex="-1" aria-labelledby="dialog_label">
                <div class="popup"> 
                    <h2 id="dialog_label">Valorizamos sua privacidade</h2>
                    <a class="close" id="close-modal" href="#open-modal-btn" role="button" aria-label="Fechar">
                    	<span aria-hidden="true">&times;</span>
                    </a>
                    <div class="contnt" tabindex="0">
                        <p>                            
                            Este site utiliza cookies para melhorar a experiência de navegação do usuário ao salvar sua preferência de contraste. A preferência será salva somente se você clicar em "Sim". Essa informação visa a melhorar a acessibilidade do website por pessoas com baixa visibilidade, que, dessa forma, não precisam reativar essa opção em um acesso futuro. Esse cookie é mantido por 30 dias.
                        </p>
                        <p>
                            A identidade dos competidores é preservada durante as competições do TreasureHunt, pois cada indivíduo é identificado por um número. Apenas o pesquisador responsável terá acesso aos dados brutos, sem qualquer identificação ou correlação nominal dos participantes.
                        </p>
                        <p>
                            Ressalta-se que o único dado sensível que a ferramenta recolhe é o endereço IP de quem a acessa, pois ele é utilizado para garantir a integridade da competição e identificar eventuais ataques e tentativas de trapaça.
                        </p>
                    </div>
                </div>
            </div>';
        }
        ?>
    </div>
</body>

</html>