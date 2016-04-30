(function(){
  var SnakeGame = window.SnakeGame = window.SnakeGame || {};
  var Constants = SnakeGame.Constants;

  var Grid = function(){
    this.width = $(document).width();
    this.height = $(document).height();
  }

  Grid.prototype.init = function(){
    this.rowSize = getRowSize(this.width);
    this.columnSize = getColumnSize(this.height);
  }

  function getRowSize(width){
    return Math.floor((width * Constants.gridPercentage) / Constants.cellSize);
  }

  function getColumnSize(height){
    return Math.floor((height * Constants.gridPercentage) / Constants.cellSize);
  }

  window.SnakeGame.Grid = Grid;
})();
