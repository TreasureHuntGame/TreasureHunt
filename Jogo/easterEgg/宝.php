<?php
header("Content-Type: text/html; charset=utf-8");
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
    <title>宝 -- TreasureHunt{Security}</title>
    <link rel="preload" href="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js" as="script">
    <link rel="preload" href="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js" as="script">
    <link rel="preload" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" as="script">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js" defer></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js" defer></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" defer></script>
    <link rel="icon" href="img/favicon_dark_tab.png">
    <link rel="preload" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" as="style">
    <link rel="preload" href="css/style.min.css" as="style">
    <link rel="preload" href="js/efeitos.min.js" as="script">
    <link rel="preload" as="style" href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300&display=swap">
    <link rel="preload" as="style" href="https://fonts.googleapis.com/css?family=Muli&display=swap">
    <link rel="preload" as="style" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.min.css">
    <script src="js/efeitos.min.js" defer></script>
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js" defer>
        </script>
    <![endif] -->

    <style>
        #tesouro {
            margin-top: 1em;
        }

        @media (max-width: 768px) {
            #tesouro {
                width: 85%;
            }

            .dica-inutil {
                margin: 0 1.5em !important;
                font-size: 0.8em;
            }

            h3 {
                margin-top: 0.2em !important;
            }
        }

        .dica-inutil {
            padding: 1em 0;
            margin: 0 5em;
            font-size: 1.1em;
        }

        h3 {
            margin-top: 1em;
        }
    </style>
</head>

<body class="text-light bg-dark">
    <input type="checkbox" name="contrast-mode" id="contrast">
    <input type="checkbox" name="animation-switch" id="animation">
    <input type="checkbox" name="close-alert" id="close-alert-button">
    <div id="page-wrapper">
        <noscript>
            <div class="jumbotron bg-dark" aria-atomic="true">
                <p>Javascript desabilitado! Algumas funcionalidades podem apresentar limitações.</p>
                <label id="close-alert-label" class="close" for="close-alert-button" tabindex="0" title="fechar aviso de javascript desabilitado" aria-label="Fechar">
                    <span aria-hidden="true">&times;</span>
                </label>
            </div>
        </noscript>
        <nav class="navbar navbar-expand-md navbar-dark justify-content-center">
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

        <main>
            <div class="jumbotron bg-dark" id="jumbotron-titulo">
                <h1 class="font-weight-bold" id="titulo-index">
                    TreasureHunt - Tesouro
                </h1>
                <h2 id="subtitulo">Você é capaz de encontrar a flag?</h2>
                <div class="row">
                    <div class="col">
                        <h3>De que adianta ganhar um tesouro se não damos valor ao que é verdadeiramente precioso?</h3>
                        <!--LiAuLi4gLi4uIC4tIC8gLS4tLiAuLi4uIC4tIC4uLi0gLiAvIC4gLi4uLiAvIC4uLSAtLSAvIC0gLiAuLi4gLS0tIC4uLSAuLS4gLS0tIC0tLS4uLiAvIC4tIC0uLi4gLS4tLiAtLi4gLiAuLi0uIC0tLiAuLi4uIC4uIC4tLS0gLS4tIC4tLi4gLS0gLS4gLS0tIC4tLS4g -->
                    </div>
                </div>
                <div class="row imagem">
                    <div class="col"></div>
                    <div class="col-md-6">
                        <!-- <img src="img/ache_a_flag.jpg" alt="moedas de ouro" class="img-fluid" id="tesouro" width="1920" height="1275"> -->
                        <img src="img/ache_a_flag.jpg" alt="moedas de ouro" class="img-fluid" id="tesouro" width="430" height="319">
                    </div>
                    <div class="col"></div>
                </div>

                <!-- 
                <p class="text-left dica-inutil">Po cara, parabéns aí, você é brabão/brabona mesmo, mas cadê a resposta do desafio? Contei pra todos aqui da minha família, todos acharam muito surpreendente e pediram pra te dar os parabéns, queriam falar com você pessoalmente se possível para lhe parabenizar. Disseram também que na próxima festa de família irão contar para os parentes mais distantes e no ano novo lançarão baterias de fogos com seu nome. Contei esse seu feito também para alguns outros parentes mais próximos, reagiram tal qual minha família, pediram seu endereço para mandar cartões e mensagem de parabenização. Meus amigos não acreditaram quando eu disse que conhecia o dono desse feito tão imenso, sério, ficaram todos de boca aberta, disseram que farão seu nome ecoar por anos e anos. Só estamos esperando você terminar o desafio xD.</p>

                <p class="text-left dica-inutil">Quando os vizinhos ficaram sabendo do feito, ficaram todos boquiabertos, quiseram saber quem é você, perguntaram se você poderia passar aqui para receber presentes, congratulações e apertos de mãos. O esparrame da sua notícia, um grande empresário da região decidiu te contratar graças a esse seu surpreendente feito; ao mesmo tempo, um grande acionista internacional quer patrocinar shows para você palestrar e ensinar todos a fazerem igual para que o mundo seja um lugar melhor. Você não só está famoso(a) aqui na região quanto aí mas também em todas as partes, todos sabem quem é você graças ao rápido esparrame da notícia, prefeitos de todas as cidades estão pendurando faixas, balões, teleféricos, instalando aparelhos de som, tudo o que possa fazer seu nome vibrar para ver qual cidade te consagra mais por esse seu feito magnifico. Ache a flag no seu tempo, viu, sem pressão.</p>

                <p class="text-left dica-inutil">Aqui na minha cidade mesmo cada rua terá seu sobrenome a partir da próxima gestão da administração municipal. Muitos países que antes viam o brasil com maus olhos, agora, graças ao seu feito, enxergam o brasil como um exemplo, como uma nova capacitação, os grandes sortudos que sabem sobre você dizem "ei, ele(a) é brasileiro(a)" e todos replicam imediatamente "é! é! é! o brasil é um bom lugar". Graças a isso o turismo aumentou no brasil, todos vieram para cá graças a você, a entrada de moedas internacionais foi grande fazendo as bolsas e ações brasileiras decolarem e assim o brasil se tornou o pilar para solução da crise mundial. Graças a isso somos bem vistos e, claro, somos a maior potẽncia econômica do mundo. Todos os madeireiros se comoveram com seu feito e decidiram parar de explorar a amazonia para que o mundo viva mais e mais. Estamos todos carinhosamente te chamando de "a pessoa que achou que ganhou, mas não completou o último desafio do easter egg". </p>

                <p class="text-left dica-inutil">Todo o preconceito foi cessado graças ao fato do brasil ser o líder economico mundial e, uma vez sendo um país de varias etnias, todos passaram a aceitar as diferenças com amor no coração. Os líderes mundiais mandaram todos os seus representantes pelo mundo falar sobre seu nome e sobre seus feitos para que a palavra sobre vossa pessoa chegue aos ouvidos de cada criatura que ande sobre a face desse planeta. Também, graças ao seu feito, decidiram cessar os experimentos com o LHC já que a origem do universo se torna sem importância perto da magnitude desse seu ato. Os maias, que voltaram a vida depois de seus atos, disseram que como existe um humano tão magnifico vivo eles iriam dar a chance de nós sobrevivermos ao apocalipse, contaram então sobre o que poderia causar o fim do mundo, e todos os lideres de todas as nações, inspirados nesse seu feito, estão tomando providências para que não ocorra. Um deles me chamou e discretamente comentou "TOME AQUI A FLAG!!!!!!!!!!", mas fiz questão de avisar que não é assim que funciona, pois é a você que ela pertecente e ela não aparecerá assim de graça, mas tenho certeza que você já sabia disso, certo? A essa altura você já deve ter encontrado a outra pista.

                <p class="text-left dica-inutil">A magnitude desse seu feito acabou até com o magnetismo que expulsou o corpo celeste alfa que habitava a órbita da terra. Em nome desse seu feito, O BTS resolveu criar um novo álbum com músicas totalmente dedicadas a você. Willian Bonner e Jô Soares ao se despedirem toda noite mandam uma saudação para o Brasil e uma somente para você. Continue sempre assim, essa pessoa linda, maravilhosa, esforçada, inspiradora, magnifica, espitufenda, criativa, etc. E continue sempre fazendo atos como estes que o mundo será cada vez mais um lugar melhor para se viver. Continue assim cara, e se sobrar um tempo visites todos os citados, ninguém acredita que eu troco mensagens virtuais. Se sobrar mais tempo ainda, vai lá e resolver o desafio, eu não aguento mais...</p>
                -->

            </div>
        </main>

        <footer class="page-footer font-small">
            <div class="col">
                <div class="footer-copyright">
                    <a rel="license noopener noreferrer" href="http://creativecommons.org/licenses/by-nc/4.0/" class="link-padrao" id="creative-commons" target="_blank">
                        <img alt="Licença Creative Commons" src="https://i.creativecommons.org/l/by-nc/4.0/80x15.png" width="80" height="15">
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
