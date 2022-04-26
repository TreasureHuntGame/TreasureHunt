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
    <title>404 -- TreasureHunt{Security}</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <link rel="icon" type="image/png" href="img/favicon_dark_tab.png">
    <link rel="preload" href="css/style.min.css" as="style">
    <link rel="preload" href="js/efeitos.min.js" as="script">
    <link rel='preload' as='style' href='https://fonts.googleapis.com/css?family=Eczar&display=swap'>
    <link rel='preload' as='style' href='https://fonts.googleapis.com/css?family=Muli&display=swap'>
    <link rel='preload' as='style' href='https://fonts.googleapis.com/icon?family=Material+Icons'>
    <base href="/TreasureHunt/">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/style.min.css">
    <link rel="stylesheet" type="text/css" href="css/400.min.css">
    <script src="js/efeitos.min.js"></script>
    <!--[if lt IE 9]>
        <script src=" https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js">
        </script>
    <![endif] -->

</head>

<body class="text-light bg-dark">
    <input type="checkbox" name="contrast-mode" id="contrast">
    <input type="checkbox" name="animation-switch" id="animation">
    <input type="checkbox" name="close-alert" id="close-alert-button">
    <div id="page-wrapper">
        <?php include "header.php" ?>

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

        <?php include "footer.php" ?>

    </div>
</body>

</html>