(function(){
  window.SnakeGame = window.SnakeGame || {};
  var Constants = window.SnakeGame.Constants;

  var Helpers = {
    getElementByPosition: function(x, y){
      return $(`[${Constants.htmlData.x}='${x}'][${Constants.htmlData.y}='${y}']`);
    },
    getElementByCell: function(cell){
      return Helpers.getElementByPosition(cell.x, cell.y);
    },
    sameCell(a, b) {
      return (a.x == b.x && a.y == b.y);
    }
  }

  window.SnakeGame.Helpers = Helpers;
})();
