$(document).on('turbolinks:load', function(){
  
  var product_image = $(".pickup__item__bottom__box__image")
 
  product_image.on("mouseover", function(){
    $(this).css("outline", "skyblue 2px solid");
  });
  product_image.on("mouseout", function(){
    $(this).css("outline", "none");
  });

  
  $(".a1 a").on("click", function(){
    $('html,body').animate({
      scrollTop: 655
  }, 100);
  return false;
  })

  $(".a2 a").on("click", function(){
    $('html,body').animate({
      scrollTop: 1295
  }, 100);
  return false;
  })

  $(".a3 a").on("click", function(){
    $('html,body').animate({
      scrollTop: 1936
  }, 100);
  return false;
  })

  $(".a4 a").on("click", function(){
    $('html,body').animate({
      scrollTop: 2576
  }, 100);
  return false;
  })

  $(".b1 a").on("click", function(){
    $('html,body').animate({
      scrollTop: 3443
  }, 100);
  return false;
  })

  $(".b2 a").on("click", function(){
    $('html,body').animate({
      scrollTop: 4082
  }, 100);
  return false;
  })

  $(".b3 a").on("click", function(){
    $('html,body').animate({
      scrollTop: 4721
  }, 100);
  return false;
  })

  $(".b4 a").on("click", function(){
    $('html,body').animate({
      scrollTop: 5359
  }, 100);
  return false;
  })




  var y = window.pageYOffset ;
  console.log(y);

});


