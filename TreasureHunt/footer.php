<footer class="page-footer font-small">
    <div class="footer-copyright">
        <a rel="license noopener noreferrer" href="http://creativecommons.org/licenses/by-nc/4.0/" id="creative-commons" class="link-padrao" target="_blank">
            <img alt="Licença Creative Commons" src="https://i.creativecommons.org/l/by-nc/4.0/80x15.png" width="80" height="15">
            <br>
            <span>Esta obra está licenciada com uma Licença <span lang="en">Creative Commons</span> Atribuição-NãoComercial 4.0 Internacional</span> (abre em nova janela).</a>
        <p><span lang="en">©</span> 2017-<?php echo date("Y"); ?></p>
    </div>
</footer>

<?php

$arquivo = basename($_SERVER['PHP_SELF']);


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
                </label>';

    echo "<a href=\"$arquivo#modal-privacy\" id=\"open-modal-btn\" class=\"btn btn-primary\" title=\"Acessar termos de privacidade\">Detalhes</a>";
    echo '</div>
        </div>
    </div>';

    echo '<div id="modal-privacy" class="overlay noscript" role="dialog" tabindex="-1" aria-labelledby="dialog_label">
    <div class="popup">
        <h2 id="dialog_label">Valorizamos sua privacidade</h2>';

    echo "<a class=\"close\" id=\"close-modal\" href=\"$arquivo#open-modal-btn\" role=\"button\" title=\"fechar janela de detalhes\" aria-label=\"Fechar\">";

    echo
    '<span aria-hidden="true">&times;</span>
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