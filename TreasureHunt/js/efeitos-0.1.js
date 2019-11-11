$(function() { 
  $('#inicio').css('font-weight', 'bold');

  $('#inicio').click(function(){
    $('#como-jogar').fadeOut(500, function() {
      $('#contatos').fadeOut(500, function() {
        $('main').fadeIn(1000);
        $('#collapsibleNavbar a').css('font-weight', 'normal');
        $('#inicio').css('font-weight', 'bold');
      });
    });
  });

  $('#regras').click(function(){
    $('main').fadeOut(500, function() {
      $('#contatos').fadeOut(500, function() {
        $('#como-jogar').fadeIn(1000);
        $('#collapsibleNavbar a').css('font-weight', 'normal');
        $('#regras').css('font-weight', 'bold');       
      });
    });
  });

  $('#contato').click(function(){
    $('main').fadeOut(500, function() {
      $('#como-jogar').fadeOut(500, function() {
        $('#contatos').fadeIn(1000);
        $('#collapsibleNavbar a').css('font-weight', 'normal');
        $('#contato').css('font-weight', 'bold');
      });
    });
  });

  $('.navbar-collapse a').click(function(){
    $(".navbar-collapse").collapse('hide');
  });

});