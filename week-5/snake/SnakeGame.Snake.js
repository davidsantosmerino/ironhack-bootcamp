(function(){
  var SnakeGame = window.SnakeGame = window.SnakeGame || {};
  var Helpers = SnakeGame.Helpers;
  var Constants = SnakeGame.Constants;
  var Entities = SnakeGame.Entities;
  var Cell = Entities.Cell;

  var Snake = function(grid, size){
    this.size = size;
    this.body = [];
    this.currentDirection = Constants.direction.left;
    this.hasEaten = false;
    this.alive = true;
    this.movements = [
      new Entities.Movement(
        Constants.direction.left,
        function(cell){return leftMovement(cell, grid.rowSize)}
      ),
      new Entities.Movement(
        Constants.direction.right,
        function(cell){return rightMovement(cell, grid.rowSize)}
      ),
      new Entities.Movement(
        Constants.direction.up,
        function(cell){return upMovement(cell, grid.columnSize)}
      ),
      new Entities.Movement(
        Constants.direction.down,
        function(cell){return downMovement(cell, grid.columnSize)}
      )
    ]
    this.init(grid);
  }

  Snake.prototype.init = function(grid) {
    var rowPosition = Math.floor(grid.rowSize / 2);
    var columnPosition = Math.floor(grid.columnSize / 2);
    var headCell = new Cell(rowPosition, columnPosition);
    for (var i = headCell.x; i < headCell.x + this.size; i++) {
      var classType = (i === headCell.x) ? Constants.cssClass.snake : Constants.cssClass.snake;
      Helpers.getElementByPosition(i, rowPosition).addClass(classType);
      var cell = new Cell(i, rowPosition);
      this.body.push(cell);
    }
  }

  Snake.prototype.move = function(){
    var newBody = [];
    moveHead.bind(this)(newBody);
    moveBody.bind(this)(newBody);
    this.body = newBody;
  }

  Snake.prototype.eat = function(foodCell) {
    if(Helpers.sameCell(foodCell, this.body[0])){
      Helpers.getElementByCell(foodCell).removeClass(Constants.cssClass.food);
      this.body.push(foodCell);
      return true;
    }
    else {
      return false;
    }
  }

  Snake.prototype.addBody = function(cell) {
    this.body.push(cell);
  }

  Snake.prototype.setCurrentDirection = function(direction){
    if(direction.oposite !== this.currentDirection){
      this.currentDirection = direction.direction;
    }
  }

  function moveHead(newBody) {
    var snake = this;
    var headCell = snake.body[0];
    var movement = $.grep(snake.movements, function(movement) {
      return movement.direction == snake.currentDirection;
    });
    var newCell = movement[0].action(headCell);
    newBody.push(newCell);
    var sharedPositions = $.grep(snake.body, function(cell) {
      return Helpers.sameCell(cell, newCell);
    });
    if(sharedPositions.length > 0){
      this.alive = false;
    }
  }

  function moveBody(newBody) {
    var body = this.body;
    for (var i = 1; i < body.length; i++) {
      var currentPosition = body[i-1];
      var prevPosition = body[i];
      newBody.push(currentPosition);
    }
  }

  function leftMovement(cell, rowSize) {
    var newCell = new Cell(cell.x, cell.y);
    newCell.x = newCell.x <= 0 ? newCell.x = rowSize - 1 : newCell.x-1;
    return newCell;
  }

  function rightMovement(cell, rowSize) {
    var newCell = new Cell(cell.x, cell.y);
    newCell.x = newCell.x >= rowSize ? newCell.x = 0 : newCell.x+1;
    return newCell;
  }

  function upMovement(cell, columnSize) {
    var newCell = new Cell(cell.x, cell.y);
    newCell.y = newCell.y <= 0 ? columnSize - 1 : newCell.y-1;
    return newCell;
  }

  function downMovement(cell, columnSize) {
    var newCell = new Cell(cell.x, cell.y);
    newCell.y = newCell.y >= columnSize - 1 ? 0 : newCell.y+1;
    return newCell;
  }

  window.SnakeGame.Snake = Snake;
})();
