$(document).on('turbolinks:load', function() {
  //始めにactionを追加
  $('.owl-items .owl-item:first-child').addClass('active');
  $('.owl-items .owl-item:first-child').css({'opacity':'1','pointer':'default'});
  //hover時に色変更&activeクラス追加
  $('.owl-item').hover(function(){
    $('.active').css({'opacity':'','pointer':''})
    $('.active').removeClass('active');
    $(this).addClass('active');
    $(this).css({'opacity':'1','pointer':'default'});
  });
  $('.owl-stage').slick({
    autoplay: false,
    Speed: 3000,
    arrows: false,
    dots: false,
    dotsClass: 'owl-items',
    pauseOnDotsHover: true,
    infinite: true,
  });
  $('.owl-item').on('mouseover', function(e){
    var $currTarget = $(e.currentTarget);
    index = $('.owl-item').index(this);
    slickObj = $('.owl-stage').slick('getSlick');
    slickObj.slickGoTo(index); 
  });
});