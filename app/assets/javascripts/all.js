document.addEventListener("touchstart", function(){}, true);

function menuButton(){
  $('#nav-open-btn, #nav-close-btn').on('click', function(e){
    e.preventDefault();
    $('#mobile-nav').toggleClass('closed');
  });
}