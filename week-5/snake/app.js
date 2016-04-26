$('document').ready(function(){
  //Objects
  var Input = function(key, direction, oposite, action){
    this.key = key;
    this.direction = direction;
    this.oposite = oposite;
    this.action = action;
  }
  //Constants
  var ROW_SIZE = 10;
  var COLUMN_SIZE = 10;
  var SNAKE_LENGTH = 5;
  var GRID_PIXELS = ROW_SIZE * COLUMN_SIZE;
  var DIRECTIONS = {
    left: "left",
    right: "right",
    up: "up",
    down: "down",
  }
  var KEY_CODES = {
    left: 97,
    right: 100,
    up: 119,
    down: 115,
    space: 32
  }
  var INPUTS = [
    new Input(KEY_CODES.left, DIRECTIONS.left, DIRECTIONS.right, function(){setCurrentDirection(this)}),
    new Input(KEY_CODES.right, DIRECTIONS.right, DIRECTIONS.left, function(){setCurrentDirection(this)}),
    new Input(KEY_CODES.up, DIRECTIONS.up, DIRECTIONS.down, function(){setCurrentDirection(this)}),
    new Input(KEY_CODES.down, DIRECTIONS.down, DIRECTIONS.up, function(){setCurrentDirection(this)}),
    new Input(KEY_CODES.space, null, null, function(){pauseToggle()}),
  ]
  //Game vars
  var CURRENT_DIRECTION = DIRECTIONS.left;
  var SNAKE = [];
  var INTERVAL_ID = 0;
  var GAME_PAUSE = false;

  function setCurrentDirection(direction){
    if(direction.oposite !== CURRENT_DIRECTION){
      CURRENT_DIRECTION = direction.direction;
    }
  }

  function pauseToggle(){
    GAME_PAUSE = !GAME_PAUSE;
    if(GAME_PAUSE){
      pause();
    }
    else {
      start();
    }
    $('.pause-container').toggleClass('no-visible');
  }

  function pause() {
    clearInterval(INTERVAL_ID);
  }

  function start(){
    INTERVAL_ID = setInterval(move, 300);
  }

  function setup(){
    for (var i = 0; i < GRID_PIXELS ; i++) {
      var pixel = $('<div>').addClass('pixel');
      $('.main-container').append(pixel);
    }
    var allPixels = $('.main-container').children();
    var headIndex = Math.floor(GRID_PIXELS / 2);
    for (var i = headIndex; i < headIndex + SNAKE_LENGTH; i++) {
      if(i === headIndex){
        $(allPixels[i]).addClass('head');
      }
      else {
        $(allPixels[i]).addClass('body');
      }
      SNAKE.push(i);
    }
  }

  function move(){
    var thisSnake = [];
    headMove(thisSnake);
    bodyMove(thisSnake);
    SNAKE = thisSnake;
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
      var currentPosition = SNAKE[i-1];
      var prevPosition = SNAKE[i];
      $(allPixels[currentPosition]).toggleClass('body');
      $(allPixels[prevPosition]).toggleClass('body');
      thisSnake.push(currentPosition);
    }
  }

  $('body').on('keypress', function(e){
    var keyCode = e.which;
    input = $.grep(INPUTS, function( direction ) {
      return direction.key == keyCode;
    });
    if(input.length > 0){
      input[0].action();
    }
  });
  setup();
  start();
});
