<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="TreasureHunt, um Jogo de Caça ao Tesouro de Segurança Computacional">
    <meta name="keywords" content="TreasureHunt, Treasure Hunt, Segurança Computacional, Cibersegurança, Cybersecurity, Computer Security">
    <meta name="author" content="Ricardo de la Rocha Ladeira">
    <title>403 -- TreasureHunt{Security}</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <link rel="icon" type="image/png" href="/TreasureHunt/img/favicon.png">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/TreasureHunt/css/style.css">
    <script src="/TreasureHunt/js/timeout-0.1.js"></script>
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <![endif]-->
</head>
<body class="text-light bg-dark">
    <nav class="navbar navbar-expand-sm navbar-dark justify-content-center">
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="navbar-collapse collapse justify-content-center" id="collapsibleNavbar">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a>Deu ruim!</a>
                </li>
            </ul>
        </div>
    </nav>
    <main>
        <div class="jumbotron bg-dark">
            <h1 class="font-weight-bold" id="erro">
            TreasureHunt<span id="espaco"> </span><span class="destaque">{</span>403<span class="destaque">}</span>
            </h1>
            <p>Você tentou acessar uma página proibida. Volte para o início ou aguarde 10 segundos para o redirecionamento automático <span class="smile destaque">:)</span></p>
        </div>
        <div class="form-signin">
            <button class="btn btn-dark btn-block" type="submit" name="inicio" onclick="voltar()">Voltar para o início</button>
        </div>
    </main>
    <footer class="page-footer font-small">
        <div class="footer-copyright">
            <a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/" id="creative-commons">
                <img alt="Licença Creative Commons" src="https://i.creativecommons.org/l/by-nc/4.0/80x15.png">
            </a>
            <br>
            <p>Esta obra está licenciada com uma Licença <a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/">Creative Commons Atribuição-NãoComercial 4.0 Internacional</a>.</p>
            <p>© 2017-2021</p>
        </div>
    </footer>    
</body>
</html>