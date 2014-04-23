// flash message
function flashMessage() {
  close = document.getElementById("flashClose");
   close.addEventListener('click', function() {
     flash = document.getElementById("flash");
     flash.style.display = 'none';
   }, false);
}