// Filter handles
function filterHandle() {
  $('.filter-handle').on('click', function() {
    var $fa = $(this).find('.fa');
    if($fa.hasClass('fa-caret-right')) {
      $fa.removeClass('fa-caret-right').addClass('fa-caret-down');
    } else {
      $fa.removeClass('fa-caret-down').addClass('fa-caret-right');
    }
    $(this).next().toggleClass('show');
  });
}

function poolPassword() {
  $input = $("input:radio[name='pool[is_public]']");
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
}

function togglePasswordFields(e) {
  if(e.checked) {
    if (e.value == 'true') {
      $("#private_pool_enabled").hide();
    } else {
      $("#private_pool_enabled").show();
    }
  }
}

function rangeSlider() {
  var Link = $.noUiSlider.Link;

  $('.rangeslider').noUiSlider({
    start: [ 5, 65 ],
    step: 5,
    behaviour: 'snap',
    range: {
      'min': 5,
      'max': 65
    },
    connect: true,
    serialization: {
      lower: [
        new Link({
          target: $('.slider').find('.min'),
        }),
        new Link({
          target: $('.slider').find('.mintext'),
          method: "text"
        })
      ],
      upper: [
        new Link({
          target: $('.slider').find('.max')
        }),
        new Link({
          target: $('.slider').find('.maxtext'),
          method: "text"
        })
      ],
      format: {
        decimals: 0
      }
    }
  });
}
function rangeSlider2() {
  var Link = $.noUiSlider.Link;

  $('.rangeslider').noUiSlider({
    start: [ 5 ],
    step: 5,
    behaviour: 'snap',
    range: {
      'min': 5,
      'max': 65
    },
    connect: 'lower',
    serialization: {
      lower: [
        new Link({
          target: $('.slider').find('.min'),
        }),
        new Link({
          target: $('.slider').find('.mintext'),
          method: "text"
        })
      ],
      format: {
        decimals: 0
      }
    }
  });
}