(function(){
  window.SnakeGame = window.SnakeGame || {};
  var Game = window.SnakeGame.Game;
  var Entities = window.SnakeGame.Entities;
  var Cell = Entities.Cell;
  var Constants = window.SnakeGame.Constants;

  var Configuration = function(rowSize, columnSize) {
    this.movements = [
      new Entities.Movement(
        Constants.direction.left,
        function(cell){return leftMovement(cell, rowSize)}
      ),
      new Entities.Movement(
        Constants.direction.right,
        function(cell){return rightMovement(cell, rowSize)}
      ),
      new Entities.Movement(
        Constants.direction.up,
        function(cell){return upMovement(cell, columnSize)}
      ),
      new Entities.Movement(
        Constants.direction.down,
        function(cell){return downMovement(cell, columnSize)}
      )
    ]
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

  window.SnakeGame.Configuration = Configuration;
})();
