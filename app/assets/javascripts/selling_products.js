$(document).on('turbolinks:load', function() {
  var modal_open = $('#modal-open-btn');
  modal_open.on("click", function(){
    $('#overlay').fadeIn();
    $(document).on("click", function(e){
      if (!$(e.target).closest('#target').length) {
      $('#overlay').fadeOut();
      }
    });
    return false;
  });
});