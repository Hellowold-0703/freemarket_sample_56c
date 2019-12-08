$(document).on('turbolinks:load', function(){
  $(function(){
    $('#slide').slick({
      autoplay: true,
      autoplaySpeed: 4000,
      dots: true,
    });
  })
});