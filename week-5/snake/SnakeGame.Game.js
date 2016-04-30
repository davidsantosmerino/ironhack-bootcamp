$(function () {
  window.SnakeGame = window.SnakeGame || {};

  var Constants = window.SnakeGame.Constants;
  var Configuration = window.SnakeGame.Configuration;
  var Entities = window.SnakeGame.Entities;
  var Cell = Entities.Cell;

  var CURRENT_DIRECTION = Constants.direction.left;

  var Game = function(){
    var game = this;
    game.snake = [];
    game.intervalId = 0;
    game.gamePause = false;
    game.foodCell = null;
    game.inputs = [
      new Entities.Input(
        Constants.keyCode.left,
        Constants.direction.left,
        Constants.direction.right,
        function(){game.setCurrentDirection(this)}
      ),
      new Entities.Input(
        Constants.keyCode.right,
        Constants.direction.right,
        Constants.direction.left,
        function(){game.setCurrentDirection(this)}
      ),
      new Entities.Input(
        Constants.keyCode.up,
        Constants.direction.up,
        Constants.direction.down,
        function(){game.setCurrentDirection(this)}
      ),
      new Entities.Input(
        Constants.keyCode.down,
        Constants.direction.down,
        Constants.direction.up,
        function(){game.setCurrentDirection(this)}
      ),
      new Entities.Input(
        Constants.keyCode.space,
        null,
        null,
        function(){game.pauseToggle()}
      ),
    ]
  }

  Game.prototype.setup = function(){
    this.addListeners();
    createGrid();
    createSnake.bind(this)();
    generateFood.bind(this)();
    this.start();
  }

  Game.prototype.setCurrentDirection = function(direction){
    if(direction.oposite !== CURRENT_DIRECTION){
      CURRENT_DIRECTION = direction.direction;
    }
  }

  Game.prototype.pauseToggle = function(){
    this.gamePause = !this.gamePause;
    if(this.gamePause)
      this.pause()
    else
      this.start();

    $('.pause-container').toggleClass(Constants.cssClass.novisible);
  }

  Game.prototype.move = function(){
    var game = this;
    var newSnake = [];
    moveHead.bind(game)(newSnake);
    moveBody.bind(game)(newSnake);
    this.eat(newSnake);
    this.snake = newSnake;
  }

  Game.prototype.addListeners = function(){
    var game = this;
    $('body').on('keypress', function(e){
      var keyCode = e.which;
      var input = $.grep(game.inputs, function(direction) {
        return direction.key == keyCode;
      });
      if(input.length > 0){
        input[0].action();
      }
    });
  }

  Game.prototype.gameOver = function() {
    var game = this;
    $('body').off();
    clearInterval(game.intervalId);
    $('.game-over-container').toggleClass(Constants.cssClass.novisible);
  }

  Game.prototype.pause = function(){
    var game = this;
    clearInterval(game.intervalId);
  }

  Game.prototype.start = function(){
    this.intervalId = setInterval(this.move.bind(this), 300);
  }

  function createGrid() {
    for (var i = 0; i < Constants.size.column ; i++) {
      for (var j = 0; j < Constants.size.row; j++) {
        var pixel = $('<div>');
        pixel.addClass(Constants.cssClass.cell);
        pixel.attr(Constants.htmlData.x, j);
        pixel.attr(Constants.htmlData.y, i);
        $('.main-container').append(pixel);
      }
    }
  }

  function createSnake() {
    var game = this;
    var rowPosition = Math.floor(Constants.size.row / 2);
    var columnPosition = Math.floor(Constants.size.column / 2);
    var headCell = new Cell(rowPosition, columnPosition);
    for (var i = headCell.x; i < headCell.x + 5; i++) {
      var classType = (i === headCell.x) ? Constants.cssClass.snake : Constants.cssClass.snake;
      getCellByPosition(i, rowPosition).addClass(classType);
      var cell = new Cell(i, rowPosition);
      game.snake.push(cell);
    }
  }

  function generateFood() {
    var game = this;
    var foodCell = new Cell(Math.floor(Math.random() * Constants.size.row), Math.floor(Math.random() * Constants.size.column));
    var sharedPositions = $.grep(game.snake, function(cell) {
      return sameCell(cell, foodCell);
    });
    if(sharedPositions.length < 1){
      getCellByPosition(foodCell.x, foodCell.y).addClass(Constants.cssClass.food);
      game.foodCell = new Cell(foodCell.x, foodCell.y);
    }
    else {
      generateFood.bind(game)();
    }
  }

  function getCellByPosition(x, y){
    return $(`[${Constants.htmlData.x}='${x}'][${Constants.htmlData.y}='${y}']`);
  }

  Game.prototype.eat = function(newSnake) {
    var newHead = newSnake[0];
    if(sameCell(this.foodCell, newHead)){
      getCellByPosition(this.foodCell.x, this.foodCell.y).toggleClass(Constants.cssClass.food);
      var movement = $.grep(Configuration.movement, function(movement) {
        return movement.direction == CURRENT_DIRECTION;
      });
      var newCell = movement[0].action(newHead);
      getCellByPosition(newCell.x, newCell.y).toggleClass(Constants.cssClass.snake);
      newSnake.unshift(newCell);
      generateFood.bind(this)();
    }
    return newSnake;
  }

  function moveHead(newSnake) {
    var snake = this.snake;
    var headCell = snake[0];
    var movement = $.grep(Configuration.movement, function(movement) {
      return movement.direction == CURRENT_DIRECTION;
    });
    var newCell = movement[0].action(headCell);
    var sharedPositions = $.grep(snake, function(cell) {
      return sameCell(cell, newCell);
    });
    if(sharedPositions.length < 1){
      getCellByPosition(headCell.x, headCell.y).toggleClass(Constants.cssClass.snake);
      getCellByPosition(newCell.x, newCell.y).toggleClass(Constants.cssClass.snake);
      newSnake.push(newCell);
    }
    else{
      this.gameOver();
    }
  }

  function moveBody(newSnake) {
    var snake = this.snake;
    for (var i = 1; i < snake.length; i++) {
      var currentPosition = snake[i-1];
      var prevPosition = snake[i];
      getCellByPosition(currentPosition.x, currentPosition.y).toggleClass(Constants.cssClass.snake);
      getCellByPosition(prevPosition.x, prevPosition.y).toggleClass(Constants.cssClass.snake);
      newSnake.push(currentPosition);
    }
  }

  function sameCell(a, b){
    return (a.x == b.x && a.y == b.y)
  }

  window.SnakeGame.Game = Game;
})
