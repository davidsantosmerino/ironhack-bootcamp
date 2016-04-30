(function(){
  window.SnakeGame = window.SnakeGame || {};
  var Game = window.SnakeGame.Game;
  var Entities = window.SnakeGame.Entities;
  var Cell = Entities.Cell;
  var Constants = window.SnakeGame.Constants;

  var Configuration = function(rowSize, columnSize) {
    this.difficultyLevels = [250, 200, 150, 100, 80, 60, 40, 35]
  }

  window.SnakeGame.Configuration = Configuration;
})();
