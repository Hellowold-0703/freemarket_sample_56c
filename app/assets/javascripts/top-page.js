$(document).on('turbolinks:load', function(){

  var product_image = $(".pickup__item__bottom__box__image")


  product_image.on("mouseover", function(){
    debugger;
    $(this).css('style.borderColor	', "blue;");
  });
});

