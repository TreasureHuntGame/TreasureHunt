
$(function() {
  $('.navbar-collapse>.navbar-nav>.nav-item>label').click(function(){
    $("#collapse-btn").prop('checked',false);
  });

  $('.label-link').keydown(function(event){
    if (event.which == 13 || event.which == 32) {
      $(this).click();
    }
  }); 
});
