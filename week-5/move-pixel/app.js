$('document').ready(function(){
  var ROW_SIZE = 10;
  var COLUMN_SIZE = 10;
  var COLORS = ['yellow', 'blue', 'green', 'red'];
  var KEYS = {
    left: 97,
    right: 100,
    up: 119,
    down: 115
  }
  var gridPixels = ROW_SIZE * COLUMN_SIZE;
  for (var i = 0; i < gridPixels ; i++) {
    var pixel = $('<div>').addClass('pixel');
    $('.main-container').append(pixel);
  }

  function findActivePixel(){
    var allPixels = $('.main-container').children();
    var activeElement = -1;
    allPixels.each(function(pixelIndex){
      var isActive = $(this).hasClass('active');
      if (isActive)
        activeElement = pixelIndex;
    });

    return activeElement;
  }

  function removeExistingActive(){
    var allPixels = $('.main-container').children();
    allPixels.each(function(pixelIndex){
      $(this).removeClass('active');
    });
  }

  $('.pixel').on('click', function(){
    removeExistingActive();
    $(this).toggleClass('active');
  });

  $('body').on('keypress', function(e){
    var allPixels = $('.main-container').children();
    var activeElement = findActivePixel();
    if(activeElement > -1){
      var newActiveElement = -1;
      switch (e.which) {
        case KEYS.left:
        if(activeElement % ROW_SIZE == 0){
          newActiveElement = activeElement + ROW_SIZE - 1;
        }
        else {
          newActiveElement = activeElement-1;
        }
          break;
        case KEYS.up:
        if(activeElement < ROW_SIZE){
          newActiveElement = activeElement + (ROW_SIZE * (COLUMN_SIZE - 1));
        }
        else{
          newActiveElement = activeElement-ROW_SIZE;
        }
          break;
        case KEYS.down:
        if(activeElement >= (ROW_SIZE * (COLUMN_SIZE - 1))){
          newActiveElement = activeElement - (ROW_SIZE * (COLUMN_SIZE - 1));
        }
        else{
          newActiveElement = activeElement+ROW_SIZE;
        }
          break;
        case KEYS.right:
        if(activeElement % ROW_SIZE == ROW_SIZE-1){
          newActiveElement = activeElement - ROW_SIZE + 1;
        }
        else {
          newActiveElement = activeElement+1;
        }
          break;
      }
      if (newActiveElement > -1 && newActiveElement < ROW_SIZE*COLUMN_SIZE ) {
        $(allPixels[activeElement]).toggleClass('active');
        $(allPixels[newActiveElement]).toggleClass('active');
      }
    }
    else {
      alert('No active element to move!');
    }
  });
});
