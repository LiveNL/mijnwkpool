$(function() {
  $input = $("input:radio[name='pool[public]']");
  $.each($input,function(k,v) {
    togglePasswordFields(v);
  });

  $input.on('change', function() {
    togglePasswordFields(this);
  });

  $('a.togglepassword').on('click', function(e) {
    $('a.togglepassword.hide').removeClass('hide');
    $(this).addClass('hide');

    e.preventDefault();
    $('.password').each(function(){
      $this = $(this);
      if($this.hasClass('hide')) {
        $this.removeClass('hide');
      } else {
        $this.addClass('hide');
      }
    });
  });
});

function togglePasswordFields(e) {
  if(e.checked) {
    if (e.value == 'true') {
      $("#private_pool_enabled").hide();
    } else {
      $("#private_pool_enabled").show();
    }
  }
}