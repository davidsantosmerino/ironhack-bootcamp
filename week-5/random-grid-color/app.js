$('document').ready(function(){
  var gridPixels = 10*10;
  var pixel = '<div class="pixel"></div>';
  for (var i = 0; i < gridPixels ; i++) {
    $('.main-container').append(pixel);
  }

  function randomizePixels() {
    var colors = ['yellow', 'blue', 'green', 'red'];
    var allPixels = $('.main-container').children();
    allPixels.each(function(pixel){
      var randomColorIndex = Math.trunc(Math.random() * (colors.length));
      $(allPixels[pixel]).attr('class', colors[randomColorIndex])
    });
  }


  setInterval(randomizePixels, 1000);

});
