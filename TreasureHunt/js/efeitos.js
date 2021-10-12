$(function () {
    // habilita o tooltip do bootstrap (mensagem no hover) 
    $('[data-toggle="tooltip"]').tooltip();

    // retrai o navbar quando um dos itens dele é clidado (versão mobile)
    $('.navbar-collapse>.navbar-nav>.nav-item>label').click(function () {
        $('#collapse-btn').prop('checked', false);
    });

    // se o JS estiver habilitado ele mostra a barra de cookie 
    $('#cookie-bar').removeClass('noscript');
    $('#modal-privacy').removeClass('noscript');

    const componentesAtivivaveis = [
        '.label-link', '#logout', '#arquivo',
        '#cookie-yes', '#cookie-no', '#open-modal-btn', '#close-modal',
        '#creative-commons', '#link-logo', '#voltar-inicio'
    ]

    componentesAtivivaveis.forEach(componente => {
        $(componente).keydown(event => {
            set_keyboard_click(event);
        });
    });

    var metaTag = document.querySelector('meta[name="theme-color"]');
    function ChangeThemeColor() {
        let color = $("#page-wrapper").css("background-color");
        metaTag.setAttribute('content', color);
    }

    // Checa se a CookieBar existe, se sim, aumenta o padding bottom do footer para
    // não cobrir nada na página.
    var cookieBar = document.getElementById('cookie-bar');
    if (cookieBar) {
        footer = document.getElementsByTagName('footer');
        footer[0].style.padding = "0 32px 110px 32px";
    }

    // cria o cookie de aceitação com valor true quando
    // "sim" é pressionado na cookie bar, 
    // em seguida exclui a cookie bar
    $('#cookie-yes').click(function () {
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
            function () {
                $('#cookie-bar').remove();
                $('#modal-privacy').remove();
                $('body').removeAttr('style');
                footer[0].style.padding = "0 32px 10px 32px";
            }, 800);
    });

    // cria o cookie de aceitação com valor false quando
    // "não" é pressionado na cookie bar, 
    // em seguida exclui a cookie bar
    $('#cookie-no').click(function () {
        setCookie('cookie_notice_accepted', 'false', 30);
        // deleta o cookie contraste se ele já existir
        deleteCookie('contrast');
        setTimeout(
            function () {
                $('#cookie-bar').remove();
                $('#modal-privacy').remove();
                $('body').removeAttr('style');
                footer[0].style.padding = "0 32px 10px 32px";
            }, 800);
    });

    // se o cookie de aceitação tiver valor true ele salva a preferência de 
    // alto contraste no cookie 'contrast'  
    $('#contrast').change(function () {
        if (getCookie('cookie_notice_accepted') === 'true') {
            if ($(this).is(':checked')) {
                setCookie('contrast', 'true', 30);
            } else {
                setCookie('contrast', 'false', 30);
            }
        }
        ChangeThemeColor();
    });

    // se o valor do cookie 'contrast' for verdadeiro ele deixa 
    // a página em alto contraste
    if (getCookie('contrast') === 'true') {
        $('#contrast').prop('checked', true);
        ChangeThemeColor();
    }

    // quando o modal é aberto adiciona a classe que trava o scroll,
    // cria variável contendo o modal e ativa função para prender o foco.
    $('#open-modal-btn').click(function () {
        $('body').addClass('disable-scroll');
        var modal = document.querySelector('#modal-privacy');
        trap_focus(modal);

    });

    // quando o modal é fechado remove a classe que trava o scroll
    $('#close-modal').click(function (e) {
        $('body').removeClass('disable-scroll');
    });

    var msg = getQueryParam('message');
    if (msg != false) {
        var input;

        switch (msg) {
            case 'user_error':
                input = $('#usuario');
                break;
            case 'passwd_error':
                input = $('#senha');
                break;
            case 'erro':
                input = $('#flag-interno');
                break;
            case 'duplicada':
                input = $('#id-problema');
                break;
            case 'formato':
                input = $('#flag-interno');
                break;
            case 'id_invalido':
                input = $('#id-problema');
                break;
            default:
                break;
        }
        input.addClass('field-error');
    };

    // função que faz um loop dos elementos focáveis de um modal,
    // prendendo o foco do usuário dentro do modal em questão.
    function trap_focus(modal) {
        var focusableEls = modal.querySelectorAll("a[href]:not([disabled]), div.contnt");
        var firstFocusableEl = focusableEls[0];
        var lastFocusableEl = focusableEls[focusableEls.length - 1];

        modal.addEventListener('keydown', function (e) {
            var isTabPressed = (e.key === 'Tab' || e.keyCode == 9);
            var isEscPressed = (e.key === 'Escape' || e.keyCorde == 27);

            if (isTabPressed && document.activeElement === modal) {
                lastFocusableEl.focus();
            }
            if (isEscPressed) {
                modal.querySelector('.close').click();
            }
            else if (!isTabPressed) {
                return;
            }

            if (e.shiftKey) {
                if (document.activeElement === firstFocusableEl) {
                    lastFocusableEl.focus();
                    e.preventDefault();
                }
            } else {
                if (document.activeElement === lastFocusableEl) {
                    firstFocusableEl.focus();
                    e.preventDefault();
                }
            }
        });
    }

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

    // reimplementando os titles que são automaticamente excluidos pelo bootstrap
    // precisam ser usados para mostrar as mensagens personalizadas de erro de formulário
    var inputs = ['#usuario', '#senha', '#id-problema', '#flag-interno', '#arquivo', '#table-individual'];
    for (input of inputs) {
        switch (input) {
            case '#usuario':
                $(input).attr('title', 'Credencial numérica atribuída a você. Precisa ser um número');
                break;
            case '#senha':
                $(input).attr('title', 'Senha fornecida junto à credencial.');
                break;
            case '#id-problema':
                $(input).attr('title', 'Número do diretório cujo exercício foi resolvido. Precisa ser um número.');
                break;
            case '#flag-interno':
                $(input).attr('title', 'Resposta encontrada. Formato: TreasureHunt{texto-aleatório}');
                break;
            default:
                break;
        }
        // quando o input recebe hover ele tira o title temporariamente para não
        // mostrar uma mensagem que já é mostrada pelos tooltips
        $(input).hover(function () {
            var title = $(this).attr('title');
            $(this).attr('tmp_title', title);
            $(this).attr('title', '');
        },
            function () {
                var recoveredTitle = $(this).attr('tmp_title');
                $(this).attr('title', recoveredTitle);
            });
        $(input).click(function () {
            var oldTitle = $(this).attr("tmp_title");
            $(this).attr("title", oldTitle);
        });
    }

    // exclui o tooltip quando o esc é pressionado
    // isso é usado para cumprir o critério 1.4.13 da WCAG
    $(document).keyup(function (event) {
        if (event.which === 27) {
            $('#usuario').tooltip('hide');
            $('#senha').tooltip('hide');
            $('#id-problema').tooltip('hide');
            $('#flag-interno').tooltip('hide');
        }
    });

    // função que procura por um query param e o retorna se encontrar
    // recebe: nome do query param a ser procurado
    // retorna: valor do query param ou false se não achar
    function getQueryParam(name) {
        var results = new RegExp('[\?&]' + name + '=([^&#]*)')
            .exec(window.location.search);

        return (results !== null) ? results[1] || 0 : false;
    }

    const changeFavicon = link => {
        let $favicon = document.querySelector('link[rel="icon"]')
        if ($favicon !== null) {
            $favicon.href = link
        } else {
            $favicon = document.createElement("link")
            $favicon.rel = "icon"
            $favicon.href = link
            document.head.appendChild($favicon)
        }
    }

    window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', e => {
        const newColorScheme = e.matches ? "dark" : "light";

        const newIcon = `img/favicon_${newColorScheme}_tab.png`

        changeFavicon(newIcon);
    });


});