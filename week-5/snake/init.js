$(function(){
  var grid = new SnakeGame.Grid();
  grid.init();
  var game = new SnakeGame.Game(grid);
  game.setup();
})
