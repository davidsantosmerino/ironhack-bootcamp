(function () {
  var SnakeGame = window.SnakeGame = window.SnakeGame || {};

  var Constants = SnakeGame.Constants;
  var Helpers = SnakeGame.Helpers;
  var Configuration = SnakeGame.Configuration;
  var Entities = SnakeGame.Entities;
  var Cell = Entities.Cell;
  var Snake = SnakeGame.Snake;


  var Game = function(grid){
    var game = this;
    this.grid = grid;
    this.configuration = new Configuration(this.grid.rowSize, this.grid.columnSize);
    this.level = 0;
    this.currentDifficulty = 0;
    this.snake = new Snake(grid, 5);
    this.intervalId = 0;
    this.gamePause = false;
    this.foodCell = null;
    var snake = this.snake;
    this.inputs = [
      new Entities.Input(
        Constants.keyCode.left,
        Constants.direction.left,
        Constants.direction.right,
        function(){snake.setCurrentDirection(this)}
      ),
      new Entities.Input(
        Constants.keyCode.right,
        Constants.direction.right,
        Constants.direction.left,
        function(){snake.setCurrentDirection(this)}
      ),
      new Entities.Input(
        Constants.keyCode.up,
        Constants.direction.up,
        Constants.direction.down,
        function(){snake.setCurrentDirection(this)}
      ),
      new Entities.Input(
        Constants.keyCode.down,
        Constants.direction.down,
        Constants.direction.up,
        function(){snake.setCurrentDirection(this)}
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
    this.drawGrid();
    this.generateFood();
    this.start();
  }

  Game.prototype.pauseToggle = function(){
    this.gamePause = !this.gamePause;
    if(this.gamePause)
      this.pause()
    else
      this.start();

    $(Constants.elements.pauseContainer).toggleClass(Constants.cssClass.novisible);
  }

  Game.prototype.tick = function(){
    eraseSnake(this.snake.body);
    this.snake.move();
    if(this.snake.eat(this.foodCell)){
      this.snakeHasEatten();
    }
    if(!this.snake.alive){
      this.gameOver();
    }
    drawSnake(this.snake.body);
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
    $(Constants.elements.gameOverContainer).toggleClass(Constants.cssClass.novisible);
  }

  Game.prototype.pause = function(){
    var game = this;
    clearInterval(game.intervalId);
  }

  Game.prototype.start = function() {
    var intervalTime = this.intervalTimeByDifficulty();
    this.intervalId = setInterval(this.tick.bind(this), intervalTime);
  }

  Game.prototype.drawGrid = function() {
    for (var i = 0; i < this.grid.columnSize ; i++) {
      for (var j = 0; j < this.grid.rowSize; j++) {
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
    var rowPosition = Math.floor(game.grid.rowSize / 2);
    var columnPosition = Math.floor(game.grid.columnSize / 2);
    var headCell = new Cell(rowPosition, columnPosition);
    for (var i = headCell.x; i < headCell.x + 5; i++) {
      var classType = (i === headCell.x) ? Constants.cssClass.snake : Constants.cssClass.snake;
      Helpers.getElementByPosition(i, rowPosition).addClass(classType);
      var cell = new Cell(i, rowPosition);
      game.snake.addBody(cell);
    }
  }

  Game.prototype.snakeHasEatten = function(){
    this.generateFood();
    this.levelUp();
  }

  Game.prototype.generateFood = function() {
    var game = this;
    var foodCell = new Cell(
      Math.floor(Math.random() * game.grid.rowSize ),
      Math.floor(Math.random() * game.grid.columnSize )
    )
    var sharedPositions = $.grep(game.snake, function(cell) {
      return sameCell(cell, foodCell);
    });
    if(sharedPositions.length < 1){
      Helpers.getElementByCell(foodCell).addClass(Constants.cssClass.food);
      game.foodCell = new Cell(foodCell.x, foodCell.y);
    }
    else {
      game.generateFood();
    }
  }

  Game.prototype.levelUp = function() {
    this.level++;
    if(this.level % 5 == 0){
      this.increaseDifficulty();
    }
  }

  Game.prototype.increaseDifficulty = function(){
    this.pause();
    this.currentDifficulty += 1;
    this.levelUpAnimation();
  }

  Game.prototype.levelUpAnimation = function() {
    var game = this;
    $(Constants.elements.levelUpContainer).removeClass(Constants.cssClass.novisible);
    setTimeout(function(){
      $(Constants.elements.levelUpContainer).addClass(Constants.cssClass.novisible);
      game.start();
    }, 2000);
  }

  Game.prototype.intervalTimeByDifficulty = function(){
    var currentDifficulty = this.currentDifficulty;
    var difficultyLevels = this.configuration.difficultyLevels;
    if(currentDifficulty < difficultyLevels.length){
      return difficultyLevels[currentDifficulty];
    }
    else{
      return difficultyLevels[difficultyLevels.length-1];
    }
  }

  function eraseSnake(snake) {
    snake.forEach(function(cell){
      Helpers.getElementByCell(cell).removeClass(Constants.cssClass.snake);
    });
  }

  function drawSnake(snake) {
    snake.forEach(function(cell){
      Helpers.getElementByCell(cell).addClass(Constants.cssClass.snake);
    });
  }

  window.SnakeGame.Game = Game;
})();
