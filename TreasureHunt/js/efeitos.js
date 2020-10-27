$(function() {

    // habilita o tooltip do bootstrap (mensagem no hover) 
    $('[data-toggle="tooltip"]').tooltip();

    // retrai o navbar quando um dos itens dele é clidado (versão mobile)
    $('.navbar-collapse>.navbar-nav>.nav-item>label').click(function() {
        $('#collapse-btn').prop('checked', false);
    });

    // se o JS estiver habilitado ele mostra a barra de cookie 
    $('#cookie-bar').removeClass('noscript');
    $('#modal-privacy').removeClass('noscript');

    // adiciona clique pelo teclado nos itens do nav
    $('.label-link').keydown(function(event) {
        set_keyboard_click(event);
    });

    // adiciona clique pelo teclado nos botões da cookie bar
    $('#cookie-yes').keydown(function(e) {
        set_keyboard_click(e);
    });

    // adiciona clique pelo teclado nos botões da cookie bar
    $('#cookie-no').keydown(function(e) {
        set_keyboard_click(e);
    });

    // adiciona clique pelo teclado nos botões da cookie bar
    $('#open-modal-btn').keydown(function(e) {
        set_keyboard_click(e);
    });

    // cria o cookie de aceitação com valor true quando
    // "sim" é pressionado na cookie bar, 
    // em seguida exclui a cookie bar
    $('#cookie-yes').click(function() {
        setCookie('cookie_notice_accepted', 'true', 30);
        // por garantia vamos verificar se o valor do cookie de aceitação está verdadeiro
        //  para evitar que o cookie 'contrast' seja criado sem consentimento   
        var cookiesAccepted = getCookie('cookie_notice_accepted');
        if (cookiesAccepted === 'true') {
            var contrastChecked = $('#contrast').is(":checked");
            if (contrastChecked) {
                setCookie('contrast', 'true', 30);
            } else {
                setCookie('contrast', 'false', 30);
            }
        }

        setTimeout(
            function() {
                $('#cookie-bar').remove();
                $('#modal-privacy').remove();
                $('body').removeAttr('style');
            }, 800);
    })

    // cria o cookie de aceitação com valor false quando
    // "não" é pressionado na cookie bar, 
    // em seguida exclui a cookie bar
    $('#cookie-no').click(function() {
        setCookie('cookie_notice_accepted', 'false', 30);
        // deleta o cookie contraste se ele já existir
        deleteCookie('contrast');
        setTimeout(
            function() {
                $('#cookie-bar').remove();
                $('#modal-privacy').remove();
                $('body').removeAttr('style');
            }, 800);
    })

    // se o cookie de aceitação tiver valor true ele salva a preferência de 
    // alto contraste no cookie 'contrast'  
    $('#contrast').change(function() {
        if (getCookie('cookie_notice_accepted') === 'true') {
            if ($(this).is(':checked')) {
                setCookie('contrast', 'true', 30);
            } else {
                setCookie('contrast', 'false', 30);
            }
        }
    });

    // se o valor do cookie 'contrast' for verdadeiro ele deixa 
    // a página em alto contraste
    if (getCookie('contrast') === 'true') {
        $('#contrast').prop('checked', true);
    }

    // quando o modal é aberto adiciona a classe que trava o scroll
    $('#open-modal-btn').click(function() {
        $('body, html').addClass('disable-scroll');
    });


    // quando o modal é fechado remove a classe que trava o scroll
    $('#close-modal').click(function(e) {
        $('body, html').removeClass('disable-scroll');
    });


    // função para permitir que os botões 'enter' e 'espaço' sejam 
    // considerados cliques
    function set_keyboard_click(event) {
        if (event.which == 13 || event.which == 32) {
            event.target.click();
        }
    }

    // se o navegador em questão for o firefox e não estiver usando https
    // ele recarrega a página com https -> resolve o bug do firefox
    var isFirefox = typeof InstallTrigger !== 'undefined';
    var oldUrl = window.location.href;
    var notUsingHttps = oldUrl.substring(4, 5) !== 's';
    if (isFirefox && notUsingHttps) {
        window.location.href = 'https://' + oldUrl.substring(7, oldUrl.length);
    }


    // função para facilitar a criação do cookie;
    // recebe: nome do cookie, valor do cookie e tempo de expiração em dias
    // retorna: nada
    function setCookie(cname, cvalue, exdays) {
        var d = new Date();
        d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
        var expires = "expires=" + d.toUTCString();
        var usingFirefox = typeof InstallTrigger !== 'undefined';
        var secure = usingFirefox ? 'SameSite=None;secure;' : '';
        document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/;" + secure;
    }

    // função para facilitar a recuperação do valor de um cookie
    // recebe: nome do cookie
    // retorna: valor do cookie em questão ou nada
    function getCookie(cname) {
        var name = cname + "=";
        var decodedCookie = decodeURIComponent(document.cookie);
        var ca = decodedCookie.split(';');
        for (var i = 0; i < ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0) == ' ') {
                c = c.substring(1);
            }
            if (c.indexOf(name) == 0) {
                return c.substring(name.length, c.length);
            }
        }
        return "";
    }

    // função que deleta um cookie
    // recebe: nome do cookie
    // retorna: nada
    function deleteCookie(name) {
        if (getCookie(name)) {
            var usingFirefox = typeof InstallTrigger !== 'undefined';
            var secure = usingFirefox ? 'SameSite=None;secure;' : '';
            document.cookie = name + "=" + ";expires=Thu, 01 Jan 1970 00:00:01 GMT;" + secure;
        }
    }

});