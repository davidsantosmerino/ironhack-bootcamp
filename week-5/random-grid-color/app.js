$('document').ready(function(){
  var COLORS = ['yellow', 'blue', 'green', 'red'];

  var gridPixels = 10*10;
  for (var i = 0; i < gridPixels ; i++) {
    var pixel = $('<div>').addClass('pixel');
    $('.main-container').append(pixel);
  }

  function setCellColor(pixel) {
    var randomColorIndex = Math.trunc (Math.random() * (COLORS.length));
    pixel.attr('class', COLORS[randomColorIndex]);
  }

  function randomizePixels() {
    var allPixels = $('.main-container').children();
    allPixels.each(function(pixel){
      setCellColor($(this));
    });
  }

  $('.pixel').on('click', function(){
    setCellColor($(this));
  });


  //setInterval(randomizePixels, 1000);

});
