$(function () {
  window.SnakeGame = window.SnakeGame || {};

  var Constants = window.SnakeGame.Constants;
  var Configuration = window.SnakeGame.Configuration;
  var Entities = window.SnakeGame.Entities;
  var Cell = Entities.Cell;


  var Game = function(){
    var game = this;
    this.rowSize = Constants.size.row;
    this.columnSize = Constants.size.column;
    this.configuration = new Configuration(this.rowSize, this.columnSize);
    this.snake = [];
    this.currentDirection = Constants.direction.left;
    this.intervalId = 0;
    this.gamePause = false;
    this.foodCell = null;
    this.inputs = [
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
    this.createGrid();
    this.createSnake();
    this.generateFood();
    this.start();
  }

  Game.prototype.setCurrentDirection = function(direction){
    if(direction.oposite !== this.currentDirection){
      this.currentDirection = direction.direction;
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
    var newSnake = [];
    moveHead.bind(this)(newSnake);
    moveBody.bind(this)(newSnake);
    this.eat(newSnake);
    eraseSnake(this.snake);
    drawSnake(newSnake);
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

  Game.prototype.start = function() {
    this.intervalId = setInterval(this.move.bind(this), 300);
  }

  Game.prototype.createGrid = function() {
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

  Game.prototype.createSnake = function() {
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

  Game.prototype.generateFood = function() {
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
      game.generateFood();
    }
  }

  Game.prototype.eat = function(newSnake) {
    var game = this;
    var newHead = newSnake[0];
    if(sameCell(this.foodCell, newHead)){
      getCellByPosition(this.foodCell.x, this.foodCell.y).removeClass(Constants.cssClass.food);
      var movement = $.grep(game.configuration.movements, function(movement) {
        return movement.direction == game.currentDirection;
      });
      var newCell = movement[0].action(newHead);
      newSnake.unshift(newCell);
      this.generateFood();
    }
    return newSnake;
  }

  function getCellByPosition(x, y){
    return $(`[${Constants.htmlData.x}='${x}'][${Constants.htmlData.y}='${y}']`);
  }

  function eraseSnake(snake){
    snake.forEach(function(cell){
      getCellByPosition(cell.x, cell.y).removeClass(Constants.cssClass.snake);
    });
  }

  function drawSnake(snake){
    snake.forEach(function(cell){
      getCellByPosition(cell.x, cell.y).addClass(Constants.cssClass.snake);
    });
  }

  function moveHead(newSnake) {
    var game = this;
    var snake = game.snake;
    var headCell = snake[0];
    var movement = $.grep(game.configuration.movements, function(movement) {
      return movement.direction == game.currentDirection;
    });
    var newCell = movement[0].action(headCell);
    var sharedPositions = $.grep(snake, function(cell) {
      return sameCell(cell, newCell);
    });
    if(sharedPositions.length < 1){
      newSnake.push(newCell);
    }
    else{
      game.gameOver();
    }
  }

  function moveBody(newSnake) {
    var snake = this.snake;
    for (var i = 1; i < snake.length; i++) {
      var currentPosition = snake[i-1];
      var prevPosition = snake[i];
      newSnake.push(currentPosition);
    }
  }

  function sameCell(a, b){
    return (a.x == b.x && a.y == b.y)
  }

  window.SnakeGame.Game = Game;
})
