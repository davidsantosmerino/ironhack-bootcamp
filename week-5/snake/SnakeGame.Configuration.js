(function(){
  window.SnakeGame = window.SnakeGame || {};

  var Configuration = function(rowSize, columnSize) {
    this.difficultyLevels = [250, 200, 150, 100, 80, 60, 40, 35]
  }

  window.SnakeGame.Configuration = Configuration;
})();
