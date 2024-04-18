<?php
header("Content-Type: text/html; charset=utf-8");
header("Content-Security-Policy: frame-ancestors 'none'");
header("X-Frame-Options: DENY");
?>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <base href="/TreasureHunt/">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="TreasureHunt, um Jogo de Caça ao Tesouro de Segurança Computacional">
    <meta name="keywords" content="TreasureHunt, Treasure Hunt, Segurança Computacional, Cibersegurança, Cybersecurity, Computer Security">
    <meta name="theme-color" content="#343A40">
    <meta name="author" content="Ricardo de la Rocha Ladeira">
    <title>404 -- TreasureHunt{Security}</title>
    <link rel="preload" href="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js" as="script">
    <link rel="preload" href="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js" as="script">
    <link rel="preload" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" as="script">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js" defer></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js" defer></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" defer></script>
    <link rel="icon" href="img/favicon_dark_tab.png">
<!-- <script src="ovum.xml"></script> -->
    <link rel="preload" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" as="style">
    <link rel="preload" href="css/style.min.css" as="style">
    <link rel="preload" href="css/400.min.css" as="style">
    <link rel="preload" href="js/efeitos.min.js" as="script">
    <link rel="preload" as="style" href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300&display=swap">
    <link rel="preload" as="style" href="https://fonts.googleapis.com/css?family=Muli&display=swap">
    <link rel="preload" as="style" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.min.css">
    <link rel="stylesheet" href="css/400.min.css">
    <script src="js/efeitos.min.js" defer></script>
    <!--[if lt IE 9]>
        <script src=" https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js">
        </script>
    <![endif] -->
</head>
<body class="text-light bg-dark">
    <input type="checkbox" name="contrast-mode" id="contrast">
    <input type="checkbox" name="animation-switch" id="animation">
    <div id="page-wrapper">
        <noscript>
            <input type="checkbox" name="close-alert" id="close-alert-button">
            <div class="jumbotron bg-dark" aria-atomic="true" id="noscript-msg">
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
            <label for="collapse-btn" class="navbar-toggler" tabindex="-1"><span class="navbar-toggler-icon"><span class="sr-only">Expandir menu de navegação</span></span></label>
            <div class="navbar-collapse collapse justify-content-center" id="collapsibleNavbar">
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
        <main>
            <div class="jumbotron bg-dark" id="jumbotron-titulo">
                <h1 class="font-weight-bold erro" id="titulo-index">
                    TreasureHunt<span id="espaco"> </span><span class="destaque chaves-left" aria-hidden="true"></span>404<span class="destaque chaves-right" aria-hidden="true"></span>
                </h1>
                <h2 class="subtitulo">Página não encontrada</h2>
                <p class="explicacao">Você tentou acessar uma página inexistente. Volte para o início clicando na logo ou no botão abaixo.
                    <span class="smile destaque"></span>
                </p>
            </div>
            <div class="jumbotron">
                <a role="button" id="voltar-inicio" class="btn btn-primary inicio-btn" href="home.php">Voltar para o ínicio</a>
            </div>
        </main>
        <footer class="page-footer font-small">
            <div class="col">
                <div class="footer-copyright">
                    <a rel="license noopener noreferrer" href="http://creativecommons.org/licenses/by-nc/4.0/" class="link-padrao" id="creative-commons" target="_blank">
                        <img alt="Licença Creative Commons" src="https://licensebuttons.net/l/by-nc/4.0/88x31.png" width="88" height="31">
                        <br>
                        <span>Esta obra está licenciada com uma Licença <span lang="en">Creative Commons</span>
                            Atribuição-NãoComercial 4.0 Internacional</span> (Abre em nova janela).</a>
                    <p><span lang="en">©</span> 2017-<?php echo date("Y"); ?></p>
                </div>
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
