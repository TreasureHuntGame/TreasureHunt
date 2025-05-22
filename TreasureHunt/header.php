<input type="radio" name="nav" id="inicio" checked tabindex="-1" class="tab">
<?php
if (isset($_SESSION['usuario'])) {
    echo '<input type="radio" name="nav" id="rank" tabindex="-1" class="tab">';
}

$eh_firefox = strpos($_SERVER['HTTP_USER_AGENT'], 'Firefox') !== false;
?>
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
    <a id="link-skip" href="#content" class="position-absolute rounded-right" accesskey="l">
        Pular para o conteúdo principal
        (Atalho: Alt<?php echo $eh_firefox ? '+Shift' : ''; ?>+L)
    </a>
    <input type="checkbox" name="collapse-btn" id="collapse-btn">
    <a class="navbar-brand nav-item" id="link-logo" href="home.php">
        <?php echo file_get_contents("img/logo.svg"); ?>
    </a>
    <label for="collapse-btn" class="navbar-toggler" tabindex="0"><span class="navbar-toggler-icon"><span class="sr-only">Expandir menu de navegação</span></span></label>
    <div class="navbar-collapse collapse justify-content-center" id="collapsibleNavbar">
        <?php
        if (basename($_SERVER['PHP_SELF']) === 'index.php' or basename($_SERVER['PHP_SELF']) === 'home.php') {
            echo '<ul class="navbar-nav mx-auto">
                <li class="nav-item">
                    <label id="inicio-label" class="label-link" for="inicio" tabindex="0" accesskey="i">
                    <span class="sr-only">Página atual:</span>
                    Início</label>
                </li>';

            if (isset($_SESSION['usuario'])) {
                echo '<li class="nav-item">
                        <label id="rank-label" class="label-link" for="rank" tabindex="0" accesskey="p">
                        <span class="sr-only">Página atual:</span>Placar</label>
                    </li>';
            }

            echo '<li class="nav-item">
                    <label id="regras-label" class="label-link" for="regras" tabindex="0" accesskey="j">
                    <span class="sr-only">Página atual:</span>Como Jogar?</label>
                </li>
                <li class="nav-item">
                    <label id="contato-label" class="label-link" for="contato" tabindex="0" accesskey="c">
                    <span class="sr-only">Página atual:</span>Contato</label>
                </li>
                <li class="nav-item">
                    <label id="acessibilidade-label" class="label-link" for="acessibilidade" tabindex="0" accesskey="s">
                    <span class="sr-only">Página atual:</span>Acessibilidade</label>
                </li>';


            if (isset($_SESSION['usuario'])) {
                echo '<li class="nav-item">
                        <a id="logout" accesskey="l" href="logout.php" class="mostrar" lang="en">Logout</a>
                    </li>';
            }

            echo '</ul>';
        }
        ?>
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