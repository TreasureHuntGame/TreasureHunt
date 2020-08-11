<?php
require_once 'conexao.php';

ob_start();
@session_start();

if (!isset($_SESSION['usuario'])) {
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
    <title>Home -- TreasureHunt{Security}</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <link rel="icon" type="image/png" href="img/favicon.png">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <script src="js/efeitos-0.2.js"></script>
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
                    <a id="inicio" accesskey="i">Início</a>
                </li>
                <li class="nav-item">
                    <a id="rank" accesskey="p">Placar</a>
                </li>
                <li class="nav-item">
                    <a id="regras" accesskey="j">Como Jogar?</a>
                </li>
                <li class="nav-item">
                    <a id="contato" accesskey="c">Contato</a>
                </li>
                <li class="nav-item">
                    <a id="logout" accesskey="l" href="logout.php">Logout</a>
                </li>
            </ul>
        </div>
    </nav>
    <main>
        <div class="jumbotron bg-dark">
            <h1 class="font-weight-bold">Principal<span class="destaque">!</span></h1>
        </div>
        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-12 col-md-6 col-lg-4 jumbotron bg-dark">
                    <h2>Seus dados:</h2>
                    <div>
                        <label class="font-weight-bold">ID:</label>
                        <span data-toggle="tooltip" data-placement="bottom" title="Número que identifica cada jogador.">
                            <?php $usuario = $_SESSION['usuario'];
                            echo $usuario ?>
                        </span>
                    </div>
                    <div>
                        <label class="font-weight-bold">Arquivo:</label>
                        <span data-toggle="tooltip" data-placement="bottom" title="Arquivo que contém os exercícios!">
                            <a id="arquivo" href="<?php print_r("Desafios/Jogador" . $usuario . ".zip") ?>">
                                <?php
                                $arquivo = "Desafios/Jogador" . $usuario . ".zip";
                                $tamanhoKB = filesize($arquivo) / 1024;
                                $partes = pathinfo($arquivo);
                                print_r("Jogador" . $usuario . ".zip" . " (formato ." . $partes['extension'] . ", tamanho " . intval($tamanhoKB) . "Kb)")
                                ?>
                            </a>
                        </span>
                    </div>
                </div>
                <div class="col-sm-12 col-md-6 col-lg-4 jumbotron bg-dark">
                    <form action="checkflag.php" method="POST" class="form-signin">
                        <h2>Submeta sua <i>flag</i>:</h2>
                        <label for="id-problema" class="sr-only">Informe o ID do problema</label>
                        <input type="number" min="1" name="problema" id="id-problema" class="form-control input-sm" placeholder="Informe o ID do problema" required data-toggle="tooltip" data-placement="bottom" title="Número do diretório cujo exercício foi resolvido.">
                        <label for="flag-interno" class="sr-only">Informe a flag</label>
                        <input type="text" id="flag-interno" name="flag" class="form-control" placeholder="Informe a flag" required data-toggle="tooltip" data-placement="bottom" title="Resposta encontrada.">
                        <!--<input type="checkbox" value="lembrar-me" id="lembrar-me"><label for="lembrar-me">Lembrar-me</label>-->
                        <button class="btn btn-dark btn-block" type="submit" name="enviar">Enviar</button>
                    </form>
                </div>
                <div id="placar-individual" class="col-sm-12 col-md-12 col-lg-4 jumbotron bg-dark">
                    <h2>Seus resultados:</h2>
                    <table class="mx-auto" title="Placar individual detalhado contendo o estado e o número de tentativas por problema.">
                        <caption>Placar individual detalhado.</caption>
                        <thead>
                            <tr>
                                <th class="align-top">Problema</th>
                                <th class="align-top">Status</th>
                                <th class="align-top">Nº de Tentativas</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php
                            $usuario = $_SESSION['usuario'];
                            $stmt = $conexao->query("SELECT idProblema, acertou, tentativas FROM TreasureHunt.Resposta WHERE idUsuario='$usuario'");
                            $i = 0;
                            while ($linha = $stmt->fetch(PDO::FETCH_OBJ)) {
                            ?>
                                <tr>
                                    <td class="align-top">
                                        <?php echo $linha->idProblema; ?>
                                    </td>
                                    <td class="align-top">
                                        <?php
                                        if ($linha->acertou > 0) {
                                            echo "Resolvido";
                                        } else {
                                            echo "Não Resolvido";
                                        }
                                        ?>
                                    </td>
                                    <td class="align-top">
                                        <?php echo $linha->tentativas; ?>
                                    </td>
                                </tr>
                            <?php
                            }
                            ?>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </main>
    <div id="ranking" class="mb-3">
        <div class="jumbotron bg-dark">
            <h1 class="font-weight-bold">Placar<span class="destaque">!</span></h1>
        </div>
        <div id="placar">
            <table class="mx-auto" title="Ranqueamento ordenado pelo número de acertos. O desempate é o horário da última submissão correta.">
                <caption>Classificação do jogo.</caption>
                <thead>
                    <tr>
                        <th class="align-top">Colocação</th>
                        <th class="align-top">Jogador (ID)</th>
                        <th class="align-top">Acertos</th>
                        <th class="align-top">Hora do Último Acerto</th>
                    </tr>
                </thead>
                <tbody>
                    <?php
                    $stmt = $conexao->query("SELECT idUsuario, SUM(acertou) AS acertos, MAX(hora) AS hora FROM TreasureHunt.Resposta GROUP BY idUsuario ORDER BY acertos DESC, hora ASC, idUsuario ASC");
                    $i = 0;
                    while ($linha = $stmt->fetch(PDO::FETCH_OBJ)) {
                    ?>
                        <tr>
                            <td class="align-top">
                                <?php echo ++$i . "º"; ?>
                            </td>
                            <td class="align-top">
                                <?php echo $linha->idUsuario; ?>
                            </td>
                            <td class="align-top">
                                <?php echo $linha->acertos; ?>
                            </td>
                            <td class="align-top">
                                <?php echo $linha->hora; ?>
                            </td>
                        </tr>
                    <?php
                    }
                    ?>
                </tbody>
            </table>
        </div>
    </div>
    <div id="como-jogar">
        <div class="jumbotron bg-dark">
            <h1 class="font-weight-bold">Como Jogar<span class="destaque">?</span></h1>
        </div>
        <ul id="lista-de-regras">
            <li><span class="prompt"></span> Na tela de início, insira seu ID e sua senha e clique em <button class="btn btn-sm btn-dark" name="enviar">Entrar</button>.
            </li>
            <li><span class="prompt"></span> Baixe e descompacte o arquivo zip disponível (sugestão: <code id="unzip"> unzip JogadorX.zip</code>, onde <code>X</code> é o seu ID). Este arquivo contém diretórios representados por números inteiros. Cada diretório contém pelo menos um arquivo.
            </li>
            <li><span class="prompt"></span> Seu objetivo é descobrir a palavra secreta (<i>flag</i>) escondida em cada um dos diretórios.
            </li>
            <li><span class="prompt"></span> Vencerá o jogo aquele que submeter mais respostas corretas em menos tempo, ou seja, o ranqueamento é feito pelo número de acertos e, em caso de empate, ficará à frente aquele que obteve seu último acerto antes.
            </li>
            <li><span class="prompt"></span> Cada <i>flag</i> descoberta é um desafio resolvido! Você só precisa realizar a submissão no sistema, informando o ID do problema (número do diretório) e a <i>flag</i> encontrada. O sistema informará se a <i>flag</i> está (in)correta.
            </li>
            <li><span class="prompt"></span> As <i>flags</i> possuem o formato <code>TreasureHunt{texto-aleatorio}</code>. Na submissão, digite toda <i>flag</i>! Exemplo: <code>TreasureHunt{dhi2uh39}</code>.
            </li>
        </ul>
    </div>
    <div id="contatos">
        <div class="jumbotron bg-dark">
            <h1 class="font-weight-bold">Contato<span class="destaque">!</span></h1>
            <h2>Interessados em fazer parte da equipe são sempre bem-vindos e podem entrar em contato. <span class="smile destaque">:)</span></h2>
        </div>
        <address>
            <a href="https://instagram.com/ricardo.delarocha" target="_blank" title="Instagram do autor Ricardo de la Rocha Ladeira (abre em nova guia)">
                <span class="nome">Ricardo de la Rocha <strong>Ladeira</strong></span>
            </a>
            <span class="sinal-menor sinal-maior">ricardo.ladeira<span class="at font-weight-bold"></span>ifc.edu.br</span>
            <br>
            <span class="nome">Rafael Rodrigues <strong>Obelheiro</strong></span>
            <span class="sinal-menor sinal-maior">rafael.obelheiro<span class="at font-weight-bold"></span>udesc.br</span>
        </address>
    </div>
    <footer class="page-footer font-small">
        <div class="footer-copyright">
            <a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/" id="creative-commons">
                <img alt="Licença Creative Commons" src="https://i.creativecommons.org/l/by-nc/4.0/80x15.png">
            </a>
            <br>
            <p>Esta obra está licenciada com uma Licença <a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/">Creative Commons Atribuição-NãoComercial 4.0 Internacional</a>.</p>
            <p>© 2017-2020</p>
        </div>
    </footer>
</body>

</html>