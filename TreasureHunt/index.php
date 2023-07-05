<?php
header('Content-Type: text/html; charset=utf-8');
header("Content-Security-Policy: frame-ancestors 'none'");
header("X-Frame-Options: DENY");
?>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="TreasureHunt, um Jogo de Caça ao Tesouro de Segurança Computacional">
    <meta name="keywords" content="TreasureHunt, Treasure Hunt, Segurança Computacional, Cibersegurança, Cybersecurity, Computer Security">
    <meta name="theme-color" content="#343A40">
    <meta name="author" content="Ricardo de la Rocha Ladeira">
    <title>TreasureHunt{Security} -- Um jogo para testar suas habilidades em Segurança Computacional!</title>
    <link rel="preload" href="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js" as="script">
    <link rel="preload" href="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js" as="script">
    <link rel="preload" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" as="script">
    <link rel="preload" href="css/style.min.css" as="style">
    <link rel="preload" href="js/efeitos.min.js" as="script">
    <link rel="preload" as="style" href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300&display=swap">
    <link rel="preload" as="style" href="https://fonts.googleapis.com/css?family=Muli&display=swap">
    <link rel="preload" as="style" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js" defer></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js" defer></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" defer></script>
    <link rel="icon" href="img/favicon_dark_tab.png">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.min.css">
    <script src="js/efeitos.min.js" defer></script>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <![endif]-->
</head>
<body>
    <input type="checkbox" name="contrast-mode" id="contrast">
    <input type="checkbox" name="animation-switch" id="animation">
    <input type="checkbox" name="close-alert" id="close-alert-button">
    <div id="page-wrapper">
        <input type="radio" name="nav" id="inicio" checked tabindex="-1" class="tab">
        <input type="radio" name="nav" id="regras" tabindex="-1" class="tab">
        <input type="radio" name="nav" id="contato" tabindex="-1" class="tab">
        <input type="radio" name="nav" id="acessibilidade" tabindex="-1" class="tab">
        <noscript>
            <div class="jumbotron bg-dark" aria-atomic="true">
                <p>Javascript desabilitado! Algumas funcionalidades podem apresentar limitações.</p>
                <label id="close-alert-label" class="close" for="close-alert-button" tabindex="0" title="fechar aviso de javascript desabilitado" aria-label="Fechar">
                    <span aria-hidden="true">&times;</span>
                </label>
            </div>
        </noscript>
        <nav class="navbar navbar-expand-md navbar-dark justify-content-center">
            <a id="link-skip" href="#content" class="position-absolute rounded-right">
                Pular para o conteúdo principal
            </a>
            <input type="checkbox" name="collapse-btn" id="collapse-btn">
            <a class="navbar-brand nav-item" id="link-logo" href="home.php">
                <?php echo file_get_contents("img/logo.svg"); ?>
            </a>
            <label for="collapse-btn" class="navbar-toggler" tabindex="0"><span class="navbar-toggler-icon"><span class="sr-only">Expandir menu de navegação</span></span></label>
            <div class="navbar-collapse collapse justify-content-center" id="collapsibleNavbar">
                <ul class="navbar-nav mx-auto">
                    <li class="nav-item"><label id="inicio-label" class="label-link" for="inicio" tabindex="0" accesskey="i"><span class="sr-only">Página atual:</span>Início
                        </label></li>
                    <li class="nav-item"><label id="regras-label" class="label-link" for="regras" tabindex="0" accesskey="j"><span class="sr-only">Página atual:</span>Como Jogar?</label></li>
                    <li class="nav-item"><label id="contato-label" class="label-link" for="contato" tabindex="0" accesskey="c"><span class="sr-only">Página atual:</span>Contato</label></li>
                    <li class="nav-item"><label id="acessibilidade-label" class="label-link" for="acessibilidade" tabindex="0" accesskey="s"><span class="sr-only">Página atual:</span>Acessibilidade</label></li>
                </ul>
            </div>
            <ul class="navbar-nav ml-auto" id="contrast-container" role="presentation">
                <li>
                    <label for="contrast" id="contrast-label" class="form-inline justify-content-end label-link contrast-label" tabindex="0" data-toggle="tooltip" data-trigger="hover focus" data-placement="bottom" title="Recurso de alto contraste" accesskey="a">
                        <span id="botao-contraste" title="Recurso de alto contraste"></span>
                        <span class="sr-only">Botão para ativar e desativar recurso de alto contraste</span>
                    </label>
                </li>
            </ul>
            <ul class="navbar-nav ml-auto" id="animation-container" role="presentation">
                <li>
                    <label for="animation" id="animation-label" class="form-inline justify-content-end label-link" tabindex="0" data-toggle="tooltip" data-trigger="hover focus" data-placement="bottom" title="Recurso para ativar e desativar animações" accesskey="m">
                        <span id="botao-animation" title="Recurso para ativar e desativar animações"></span>
                        <span class="sr-only">Botão para ativar e desativar animações</span>
                    </label>
                </li>
            </ul>
        </nav>
        <span id="content" class="sr-only">Conteúdo Principal:</span>
        <div id="main" role="main" aria-label="Início">
            <div class="jumbotron bg-dark" id="jumbotron-index">
                <h1 class="font-weight-bold" id="titulo-index" lang="en">
                    TreasureHunt<span id="espaco"> </span><span class="destaque chaves-left" aria-hidden="true"></span>Security<span class="destaque chaves-right" aria-hidden="true"></span>
                </h1>
                <h2 class="subtitulo">Um jogo para testar suas habilidades em Segurança Computacional. <span class="smile destaque" aria-hidden="true"></span></h2>
            </div>
            <form action="acesso.php" method="POST" class="form-signin" autocomplete="on">
                <h3 class="h6">Autentique-se:</h3>
                <label for="usuario" class="sr-only">Informe seu ID (obrigatório):</label>
                <input type="number" name="usuario" id="usuario" class="form-control input-sm" placeholder="ID da conta (Exemplo: 1)" title="Credencial numérica atribuída a você." data-trigger="focus" data-offset="400" data-toggle="tooltip" data-placement="top" required>
                <label for="senha" class="sr-only">Informe sua senha (obrigatório):</label>
                <input type="password" id="senha" name="senha" class="form-control" autocomplete="current-password" placeholder="Informe sua senha" title="Senha fornecida junto à credencial." data-trigger="focus" data-toggle="tooltip" data-offset="400" data-placement="top" required>
                <button class="btn btn-dark btn-block" type="submit" name="enviar">Entrar</button>
                <?php
                if (isset($_GET['message'])) {
                    switch ($_GET['message']) {
                        case 'passwd_error':
                            echo '<div class="alert alert-danger login" role="alert" aria-atomic="true"> Senha incorreta ou não informada! Verifique se a senha não foi alterada recentemente e se as teclas Caps Lock e Num Lock estão ativadas.</div>';
                            break;
                        case 'user_error':
                            echo '<div class="alert alert-danger login" role="alert" aria-atomic="true"> Usuário incorreto ou não informado! Verifique se o identificador foi digitado corretamente.</div>';
                            break;
                    }
                }
                ?>
            </form>
        </div>
        <div id="como-jogar" role="main" aria-label="Como Jogar">
            <div class="jumbotron bg-dark">
                <h2 class="font-weight-bold page-title">Como Jogar<span class="destaque">?</span></h2>
            </div>
            <ul id="lista-de-regras">
                <li><span class="prompt"></span> Na tela de início, insira seu ID e sua senha e clique em
                    <button class="btn btn-sm btn-dark" name="enviar" tabindex="-1">Entrar</button>.
                </li>
                <li><span class="prompt"></span> Baixe e descompacte o arquivo zip disponível (sugestão: <code id="unzip"> unzip JogadorX.zip</code>, onde <code>X</code> é o seu ID). Este arquivo contém diretórios representados por números inteiros. Cada diretório contém pelo menos um arquivo.
                </li>
                <li><span class="prompt"></span> Seu objetivo é descobrir a palavra secreta (<em lang="en">flag</em>) escondida em cada um dos diretórios.
                </li>
                <li><span class="prompt"></span> Vencerá o jogo aquele que submeter mais respostas corretas em menos tempo, ou seja, o ranqueamento é feito pelo número de acertos e, em caso de empate, ficará à frente aquele que obteve seu último acerto antes.
                </li>
                <li><span class="prompt"></span> Cada <em lang="en">flag</em> descoberta é um desafio resolvido! Você só precisa realizar a submissão no sistema, informando o ID do problema (número do diretório) e a <em lang="en">flag</em> encontrada. O sistema informará se a <em lang="en">flag</em> está (in)correta.
                </li>
                <li><span class="prompt"></span> As <em lang="en">flags</em> possuem o formato <code> <span lang="en">TreasureHunt</span>{texto-aleatorio}</code>. Na submissão, digite toda <em lang="en">flag</em>! Exemplo: <code> <span lang="en">TreasureHunt</span>{dhi2uh39}</code>.
                </li>
            </ul>
        </div>
        <div id="contatos" role="main" aria-label="Contatos">
            <div class="jumbotron bg-dark">
                <h2 class="font-weight-bold page-title">Contato<span class="destaque">!</span></h2>
                <h3>Interessados em fazer parte da equipe são sempre bem-vindos e podem entrar em contato. <span class="smile destaque" aria-hidden="true"></span></h3>
            </div>
            <address>
                <span class="address-title">Equipe atual:</span>
                <div class="contato">
                    <span class="nome-autor">Ricardo de la Rocha Ladeira</span>:
                    <span><span class="sinal-menor" aria-hidden="true"></span>ricardo.ladeira<span class="at font-weight-bold"></span>ifc.edu.br<span class="sinal-maior" aria-hidden="true"></span></span>
                </div>
                <div class="contato">
                    <span class="nome-autor">Fernanda Ribeiro Martins</span>:
                    <span><span class="sinal-menor" aria-hidden="true"></span>fernandamartins.rm<span class="at font-weight-bold"></span>gmail.com<span class="sinal-maior" aria-hidden="true"></span></span>
                </div>
                <span class="address-title">Contribuidores:</span>
                <div class="contato nome-contrib">
                    <span>Camily do Nascimento Ghellar</span>
                </div>
                <div class="contato nome-contrib">
                    <span>Gabriel Eduardo Lima</span>
                </div>                
                <div class="contato nome-contrib">
                    <span>Henrique Arnicheski Dalposso</span>
                </div>                
                <div class="contato nome-contrib">
                    <span>Lucas Vargas</span>
                </div>
                <div class="contato nome-contrib">
                    <span>Rafael Rodrigues Obelheiro</span>
                </div>
                <div class="contato nome-contrib">
                    <span>Richard Robert Dias Custódio</span>
                </div>
                <div class="contato nome-contrib">
                    <span>Vinícius Manuel Martins</span>
                </div>
                <div class="contato nome-contrib">
                    <span>Vitor Augusto Ueno Otto</span>
                </div>
            </address>
        </div>
        <div id="sobre-acessibilidade" role="main" aria-label="Acessibilidade">
            <div class="jumbotron bg-dark">
                <h2 class="font-weight-bold page-title">Acessibilidade<span class="destaque">!</span></h2>
            </div>
            <div class="acess-conteudo">
                <h3 class="h3-acessibilidade">Acessibilidade do Site</h3>
                <p>
                    A interface do <em lang="en">TreasureHunt</em> foi desenvolvida para ser acessível e fácil de usar para o maior
                    número possível de usuários. Para isso, a equipe realiza um trabalho contínuo de atualizações
                    e melhorias, utilizando como base diretrizes e recomendações de acessibilidade.
                </p>
                <p>
                    A equipe busca aprimorar a interface do <em lang="en">TreasureHunt</em>
                    para cumprir principalmente o nível A da WCAG (<em lang="en">Web Content Accessibility Guidelines</em>,
                    Diretrizes de Acessibilidade para Conteúdo Web),
                    bem como satisfazer o maior número possível de critérios dos níveis AA e AAA.
                    Juntamente, busca-se conformidade com os padrões HTML e CSS da
                    W3C (<em lang="en">World Wide Web Consortium</em>, Consórcio da Rede Mundial de Internet).
                </p>
                <p>
                    O site possui em seu formato padrão uma relação de contraste de no mínimo 4:5:1 respeitando o critério 1.4.3 da WCAG,
                    e dispõe também de um modo de alto contraste com relação superior a 7:1 satisfazendo o critério 1.4.6. São cumpridos ainda,
                    dentre outros, os seguintes critérios:
                </p>
                <ul class="ul-acessibilidade">
                    <li><span class="prompt"></span><span>Critério 1.4.4: Zoom de até 200% sem perda de conteúdo.</span></li>
                    <li><span class="prompt"></span><span>Critério 2.1.3: Navegação completa da página pelo teclado.</span></li>
                    <li><span class="prompt"></span><span>Critério 2.3.1: Limite de três flashes em um segundo.</span></li>
                    <li><span class="prompt"></span><span>Critério 2.4.7: Foco visível nos elementos.</span></li>
                    <li><span class="prompt"></span><span>Critério 3.3.1: Identificação de erro nos formulários. </span></li>
                </ul>
                <p>
                    É possível conferir todos os
                    <a rel="noopener noreferrer" class="link-padrao" href="https://docs.google.com/spreadsheets/d/1r6ifZskz3rcLPS9CdXQj9zscRncGMhmOs81W8IWGYfA/edit?usp=sharing" target="_blank">
                        critérios cumpridos pelo Treasure Hunt em uma planilha online (abre em nova janela)
                    </a>
                </p>
                <h3 class="h3-acessibilidade"> Problemas ou Sugestões </h3>
                <p>
                    Para relatar problemas com a acessibilidade do site ou enviar sugestões de melhorias,
                    pode-se entrar em contato com os emails disponiveis na página "Contato".
                </p>
                <h3 class="h3-acessibilidade"> Teclas de Atalho </h3>
                <p>
                    A interface web conta com atalhos que possibilitam navegar pela barra de navegação,
                    ativar o modo de alto contraste e desativar as animações pelo teclado. Alguns navegadores
                    possuem teclas que devem ser pressionadas em conjunto com as teclas de atalho:
                    No <em lang="en">Chrome, Edge e Explorer</em> é utilizado o ALT, enquanto que no <em lang="en"> Firefox </em>
                    é utilizada a combinação ALT + SHIFT. Os atalhos são:
                </p>
                <ul class="ul-acessibilidade">
                    <li><span class="prompt"></span><span>A: ativa o modo de alto contraste </span></li>
                    <li><span class="prompt"></span><span>M: desativa/ativa as animações </span></li>
                    <li><span class="prompt"></span><span>I: leva para a página: “Inicío”</span></li>
                    <li><span class="prompt"></span><span>J: leva para a página: “Como jogar?”</span></li>
                    <li><span class="prompt"></span><span>C: leva para a página: “Contatos”</span></li>
                    <li><span class="prompt"></span><span>S: leva para a página: “Acessibilidade”</span></li>
                    <li><span class="prompt"></span><span>P: leva para página: “Placar” (exige autenticação)</span></li>
                    <li><span class="prompt"></span><span>L: Faz o <em lang="en">logout</em> (exige autenticação)</span></li>
                </ul>
                <div id="div-accesskeys" class="noscript">
                    <span>
                        É possível desativar e ativar as teclas de atalho com o botão abaixo:
                    </span>
                    <input type="checkbox" id="checkbox-accesskeys">
                    <label id="label-accesskeys" for="checkbox-accesskeys" tabindex="0" class="btn btn-primary btn-lg label-link" data-toggle="tooltip" data-trigger="hover focus" data-placement="bottom" title="Mecanismo para desativar e ativar as teclas de atalho">Desativar as teclas de atalho</label>
                </div>
            </div>
        </div>
        <footer class="page-footer font-small">
            <div class="footer-copyright">
                <a rel="license noopener noreferrer" href="http://creativecommons.org/licenses/by-nc/4.0/" id="creative-commons" class="link-padrao" target="_blank">
                    <img alt="Licença Creative Commons" src="https://licensebuttons.net/l/by-nc/4.0/88x31.png" width="88" height="31">
                    <br>
                    <span>Esta obra está licenciada com uma Licença <span lang="en">Creative Commons</span> Atribuição-NãoComercial 4.0 Internacional</span> (abre em nova janela).</a>
                <p><span lang="en">©</span> 2017-<?php echo date("Y"); ?></p>
            </div>
        </footer>
        <?php
        if (!(isset($_COOKIE['cookie_notice_accepted']))) {
            echo '<input type="checkbox" name="hide-cookie-bar" id="hide-cookie-bar">
            <div id="cookie-bar" class="navbar fixed-bottom container-fluid noscript">
                <div class="row mx-auto">
                    <div class="col-lg-7 col-sm-12">
                        <span>
                            Nós usamos cookies para armazenar as preferências de contraste dos usuários.
                            Ao clicar em "Sim", assumiremos que você está de acordo com isso.
                        </span>
                    </div>
                    <div class="col-lg-5 col-sm-12 ml-auto">
                        <label for="hide-cookie-bar">
                        <a class="btn btn-primary" id="cookie-yes" tabindex="0" role="button" title="Aceitar uso de cookie para armazenamento de preferências e termos de privacidade">Sim</a>
                        <a class="btn btn-primary" id="cookie-no" tabindex="0" role="button" title="Rejeitar uso de cookie para armazenamento de preferências e termos de privacidade">Não</a>
                        </label>
                        <a href="#modal-privacy" id="open-modal-btn" class="btn btn-primary" title="Acessar termos de privacidade">Detalhes</a>
                    </div>
                </div>
             </div>';
            echo '<div id="modal-privacy" class="overlay noscript" role="dialog" tabindex="-1" aria-labelledby="dialog_label">
                <div class="popup"> 
                    <h2 id="dialog_label">Valorizamos sua privacidade</h2>
                    <a class="close" id="close-modal" href="#open-modal-btn" role="button" title="fechar janela de detalhes" aria-label="Fechar">
                    	<span aria-hidden="true">&times;</span>
                    </a>
                    <div class="contnt" tabindex="0">
                        <p>                            
                            Este site utiliza cookies para melhorar a experiência de 
                            navegação do usuário ao salvar sua preferência de contraste. 
                            A preferência será salva somente se você clicar em "Sim". 
                            Essa informação visa a melhorar a acessibilidade do website
                            por pessoas com baixa visibilidade, que, dessa forma, 
                            não precisam reativar essa opção em um acesso futuro.
                            Esse cookie é mantido por 30 dias.
                        </p>
                        <p>
                            A identidade dos competidores é preservada durante as competições 
                            do TreasureHunt, pois cada indivíduo é identificado por um número. 
                            Apenas o pesquisador responsável terá acesso aos dados brutos,
                            sem qualquer identificação ou correlação nominal dos participantes.
                        </p>
                        <p>
                            Ressalta-se que o único dado sensível que a ferramenta recolhe é 
                            o endereço IP de quem a acessa, pois ele é utilizado para garantir 
                            a integridade da competição e identificar eventuais ataques e 
                            tentativas de trapaça.
                        </p>
                    </div>
                </div>
            </div>';
        }
        ?>
    </div>
</body>
</html>