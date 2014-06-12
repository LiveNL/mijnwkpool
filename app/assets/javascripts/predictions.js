$(function() {
  // $(".infoshower").hover(function () {
  //   $(this).find(".hiddeninfo").fadeIn('fast');
  // }, function () {
  //   $(this).find(".hiddeninfo").fadeOut('fast');
  // });

  $infoshower = $('.infoshower');

  $infoshower.on('click', function(e){
    $this = $(this);
    $('.infoactive').not($this).removeClass('infoactive');
    $this.toggleClass('infoactive');
  });
});