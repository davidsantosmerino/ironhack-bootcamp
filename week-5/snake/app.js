$('document').ready(function(){
  var ROW_SIZE = 10;
  var COLUMN_SIZE = 10;
  var KEYS = {
    left: 97,
    right: 100,
    up: 119,
    down: 115
  }
  var DIRECTIONS = {
    left: 'l',
    right: 'r',
    up: 'u',
    down: 'd'
  }
  var CURRENT_DIRECTION = DIRECTIONS.left;
  var SNAKE_LENGTH = 3;
  var GRID_PIXELS = ROW_SIZE * COLUMN_SIZE;
  var SNAKE = [];

  function start(){
    for (var i = 0; i < GRID_PIXELS ; i++) {
      var pixel = $('<div>').addClass('pixel');
      $('.main-container').append(pixel);
    }
    var allPixels = $('.main-container').children();
    var randomIndex = Math.floor(Math.random() * allPixels.length - 3);
    for (var i = randomIndex; i < randomIndex + SNAKE_LENGTH; i++) {
      if(i === randomIndex){
        $(allPixels[i]).addClass('head');
      }
      else {
        $(allPixels[i]).addClass('body');
      }
      SNAKE.push(i);
    }
    setInterval(move, 300)
  }

  function removeExistingActive(){
    var allPixels = $('.main-container').children();
    allPixels.each(function(pixelIndex){
      $(this).removeClass('head');
    });
  }

  function move(){
    var thisSnake = [];
    var headIndex = SNAKE[0];
    if(headIndex > -1){
      headMove(thisSnake);
      bodyMove(thisSnake);
      SNAKE = thisSnake;
    }
  }

  function headMove(thisSnake){
    headIndex = SNAKE[0];
    var allPixels = $('.main-container').children();
    var newHeadElement = -1;
    switch (CURRENT_DIRECTION) {
      case DIRECTIONS.left:
      if(headIndex % ROW_SIZE == 0){
        newHeadElement = headIndex + ROW_SIZE - 1;
      }
      else {
        newHeadElement = headIndex-1;
      }
        break;
      case DIRECTIONS.up:
      if(headIndex < ROW_SIZE){
        newHeadElement = headIndex + (ROW_SIZE * (COLUMN_SIZE - 1));
      }
      else{
        newHeadElement = headIndex-ROW_SIZE;
      }
        break;
      case DIRECTIONS.down:
      if(headIndex >= (ROW_SIZE * (COLUMN_SIZE - 1))){
        newHeadElement = headIndex - (ROW_SIZE * (COLUMN_SIZE - 1));
      }
      else{
        newHeadElement = headIndex+ROW_SIZE;
      }
        break;
      case DIRECTIONS.right:
      if(headIndex % ROW_SIZE == ROW_SIZE-1){
        newHeadElement = headIndex - ROW_SIZE + 1;
      }
      else {
        newHeadElement = headIndex+1;
      }
        break;
    }
    if (newHeadElement > -1 && newHeadElement < ROW_SIZE*COLUMN_SIZE ) {
      $(allPixels[headIndex]).toggleClass('head');
      $(allPixels[newHeadElement]).toggleClass('head');
      thisSnake.push(newHeadElement);
    }
  }

  function bodyMove(thisSnake) {
    var allPixels = $('.main-container').children();
    for (var i = 1; i < SNAKE.length; i++) {
      currentPosition = SNAKE[i-1];
      prevPosition = SNAKE[i];
      $(allPixels[currentPosition]).toggleClass('body');
      $(allPixels[prevPosition]).toggleClass('body');
      thisSnake.push(currentPosition);
    }
  }

  $('.pixel').on('click', function(){
    removeExistingActive();
    $(this).toggleClass('head');
  });

  $('body').on('keypress', function(e){
    switch (e.which) {
      case KEYS.left:
      CURRENT_DIRECTION = DIRECTIONS.left;
        break;
      case KEYS.up:
      CURRENT_DIRECTION = DIRECTIONS.up;
        break;
      case KEYS.down:
      CURRENT_DIRECTION = DIRECTIONS.down;
        break;
      case KEYS.right:
      CURRENT_DIRECTION = DIRECTIONS.right;
        break;
    }
  });

  start();
});
