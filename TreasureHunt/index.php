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
    <meta name="theme-color" content="#343A40" />
    <meta name="author" content="Ricardo de la Rocha Ladeira">
    <title>TreasureHunt{Security} -- Um jogo para testar suas habilidades em Segurança Computacional!</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <link rel="icon" type="image/png" href="img/favicon_dark_tab.png">
    <link rel="preload" href="css/style.min.css" as="style">
    <link rel="preload" href="js/efeitos.min.js" as="script">
    <link rel='preload' as='style' href='https://fonts.googleapis.com/css?family=Eczar&display=swap'>
    <link rel='preload' as='style' href='https://fonts.googleapis.com/css?family=Muli&display=swap'>
    <link rel='preload' as='style' href='https://fonts.googleapis.com/icon?family=Material+Icons'>

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/style.min.css">
    <script src="js/efeitos.min.js"></script>
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
        <?php include "header.php" ?>
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
                    <span class="btn btn-sm btn-dark">Entrar</span>.
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
                    <span class="nome-autor">Vítor Augusto Ueno Otto</span>:
                    <span><span class="sinal-menor" aria-hidden="true"></span>vitoruenootto<span class="at font-weight-bold"></span>gmail.com<span class="sinal-maior" aria-hidden="true"></span></span>
                </div>
                <div class="contato">
                    <span class="nome-autor">Lucas Vargas</span>:
                    <span><span class="sinal-menor" aria-hidden="true"></span>lucasvargas27<span class="at font-weight-bold"></span>hotmail.com<span class="sinal-maior" aria-hidden="true"></span></span>
                </div>

                <span class="address-title">Contribuidores:</span>
                <div class="contato nome-contrib">
                    <span>Henrique Arnicheski Dalposso</span>
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
                    <a rel="noopener noreferrer" class="link-padrao" href="https://docs.google.com/spreadsheets/d/1QwY4zQd_fF0Rss1fDj7d06v2b5BDnO0CrUsNnYmKyMU/edit#gid=0" target="_blank">
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
        <?php include "footer.php" ?>


    </div>
</body>

</html>