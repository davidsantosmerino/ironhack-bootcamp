(function () {
  window.SnakeGame = window.SnakeGame || {};
  var Entities = window.SnakeGame.Entities = {
    Input: function(key, direction, oposite, action){
      this.key = key;
      this.direction = direction;
      this.oposite = oposite;
      this.action = action;
    },
    Movement: function(direction, action){
      this.direction = direction;
      this.action = action;
    },
    Cell: function(x, y){
      this.x = x;
      this.y = y;
    }
  }
})();
