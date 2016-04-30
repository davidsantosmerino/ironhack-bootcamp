$(function(){
  window.SnakeGame = window.SnakeGame || {};
  var Game = window.SnakeGame.Game;
  var Entities = window.SnakeGame.Entities;
  var Cell = Entities.Cell;
  var Constants = window.SnakeGame.Constants;

  window.SnakeGame.Configuration = {
    movement: [
      new Entities.Movement(
        Constants.direction.left,
        function(cell){return leftMovement(cell)}
      ),
      new Entities.Movement(
        Constants.direction.right,
        function(cell){return rightMovement(cell)}
      ),
      new Entities.Movement(
        Constants.direction.up,
        function(cell){return upMovement(cell)}
      ),
      new Entities.Movement(
        Constants.direction.down,
        function(cell){return downMovement(cell)}
      )
    ]
  }

  function leftMovement(cell) {
    var newCell = new Cell(cell.x, cell.y);
    newCell.x = newCell.x <= 0 ? newCell.x = Constants.size.row - 1 : newCell.x-1;
    return newCell;
  }

  function rightMovement(cell) {
    var newCell = new Cell(cell.x, cell.y);
    newCell.x = newCell.x >= Constants.size.row-1 ? newCell.x = 0 : newCell.x+1;
    return newCell;
  }

  function upMovement(cell) {
    var newCell = new Cell(cell.x, cell.y);
    newCell.y = newCell.y <= 0 ? Constants.size.column - 1 : newCell.y-1;
    return newCell;
  }

  function downMovement(cell) {
    var newCell = new Cell(cell.x, cell.y);
    newCell.y = newCell.y >= Constants.size.column -1 ? 0 : newCell.y+1;
    return newCell;
  }
});
