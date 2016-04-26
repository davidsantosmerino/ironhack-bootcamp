$('document').ready(function(){
  //Constants
  var HTML_DATA = {
    x: 'data-x',
    y: 'data-y'
  }
  var ROW_SIZE = 10;
  var COLUMN_SIZE = 10;
  var SNAKE_LENGTH = 5;
  var GRID_PIXELS = ROW_SIZE * COLUMN_SIZE;
  var CSS_CLASS = {
    head: 'head',
    body: 'body',
    cell: 'cell',
    novisible: 'no-visible'
  }
  var DIRECTION = {
    left: "left",
    right: "right",
    up: "up",
    down: "down",
  }
  var KEY_CODE = {
    left: 97,
    right: 100,
    up: 119,
    down: 115,
    space: 32
  }

  //Objects
  var Input = function(key, direction, oposite, action){
    this.key = key;
    this.direction = direction;
    this.oposite = oposite;
    this.action = action;
  }
  var Movement = function(direction, action){
    this.direction = direction;
    this.action = action;
  }
  var Cell = function(x, y){
    this.x = x;
    this.y = y;
  }

  var INPUTS = [
    new Input(KEY_CODE.left, DIRECTION.left, DIRECTION.right, function(){setCurrentDirection(this)}),
    new Input(KEY_CODE.right, DIRECTION.right, DIRECTION.left, function(){setCurrentDirection(this)}),
    new Input(KEY_CODE.up, DIRECTION.up, DIRECTION.down, function(){setCurrentDirection(this)}),
    new Input(KEY_CODE.down, DIRECTION.down, DIRECTION.up, function(){setCurrentDirection(this)}),
    new Input(KEY_CODE.space, null, null, function(){pauseToggle()}),
  ]
  var MOVEMENTS = [
    new Movement(DIRECTION.left, function(cell){return leftMovement(cell)}),
    new Movement(DIRECTION.right, function(cell){return rightMovement(cell)}),
    new Movement(DIRECTION.up, function(cell){return upMovement(cell)}),
    new Movement(DIRECTION.down, function(cell){return downMovement(cell)}),
  ]
  //Game vars
  var CURRENT_DIRECTION = DIRECTION.left;
  var SNAKE = [];
  var INTERVAL_ID = 0;
  var GAME_PAUSE = false;

  function leftMovement(cell) {
    var newCell = new Cell(cell.x, cell.y);
    newCell.x = newCell.x <= 0 ? newCell.x = ROW_SIZE - 1 : newCell.x-1;
    return newCell;
  }

  function rightMovement(cell) {
    var newCell = new Cell(cell.x, cell.y);
    newCell.x = newCell.x >= ROW_SIZE-1 ? newCell.x = 0 : newCell.x+1;
    return newCell;
  }

  function upMovement(cell) {
    var newCell = new Cell(cell.x, cell.y);
    newCell.y = newCell.y <= 0 ? COLUMN_SIZE - 1 : newCell.y-1;
    return newCell;
  }

  function downMovement(cell) {
    var newCell = new Cell(cell.x, cell.y);
    newCell.y = newCell.y >= COLUMN_SIZE -1 ? 0 : newCell.y+1;
    return newCell;
  }

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
    $('.pause-container').toggleClass(CSS_CLASS.novisible);
  }

  function pause() {
    clearInterval(INTERVAL_ID);
  }

  function start(){
    INTERVAL_ID = setInterval(move, 300);
  }

  function createGrid() {
    for (var i = 0; i < COLUMN_SIZE ; i++) {
      for (var j = 0; j < ROW_SIZE; j++) {
        var pixel = $('<div>');
        pixel.addClass(CSS_CLASS.cell);
        pixel.attr(HTML_DATA.x, j);
        pixel.attr(HTML_DATA.y, i);
        $('.main-container').append(pixel);
      }
    }
  }

  function createSnake() {
    var rowPosition = Math.floor(ROW_SIZE / 2);
    var columnPosition = Math.floor(COLUMN_SIZE / 2);
    var headCell = new Cell(rowPosition, columnPosition);
    for (var i = headCell.x; i < headCell.x + SNAKE_LENGTH; i++) {
      var classType = (i === headCell.x) ? CSS_CLASS.head : CSS_CLASS.body;
      getCellByPosition(i, rowPosition).addClass(classType);
      var cell = new Cell(i, rowPosition);
      SNAKE.push(cell);
    }
  }

  function getCellByPosition(x, y){
    return $(`[${HTML_DATA.x}='${x}'][${HTML_DATA.y}='${y}']`);
  }

  function setup(){
    createGrid();
    createSnake();
    start();
  }

  function move(){
    var newSnake = [];
    moveHead(newSnake);
    moveBody(newSnake);
    SNAKE = newSnake;
  }

  function moveHead(newSnake){
    var headCell = SNAKE[0];
    var movement = $.grep(MOVEMENTS, function(movement) {
      return movement.direction == CURRENT_DIRECTION;
    });
    var newCell = movement[0].action(headCell);
    getCellByPosition(headCell.x, headCell.y).toggleClass(CSS_CLASS.head);
    getCellByPosition(newCell.x, newCell.y).toggleClass(CSS_CLASS.head);
    newSnake.push(newCell);
  }

  function moveBody(newSnake) {
    for (var i = 1; i < SNAKE.length; i++) {
      var currentPosition = SNAKE[i-1];
      var prevPosition = SNAKE[i];
      getCellByPosition(currentPosition.x, currentPosition.y).toggleClass(CSS_CLASS.body);
      getCellByPosition(prevPosition.x, prevPosition.y).toggleClass(CSS_CLASS.body);
      newSnake.push(currentPosition);
    }
  }

  $('body').on('keypress', function(e){
    var keyCode = e.which;
    var input = $.grep(INPUTS, function(direction) {
      return direction.key == keyCode;
    });
    if(input.length > 0){
      input[0].action();
    }
  });

  setup();
});
