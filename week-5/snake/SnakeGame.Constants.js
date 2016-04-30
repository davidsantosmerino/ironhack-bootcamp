(function () {
  window.SnakeGame = window.SnakeGame || {};
  var Constants = window.SnakeGame.Constants = {
    htmlData: {
      x: 'data-x',
      y: 'data-y'
    },
    cssClass: {
      head: 'head',
      body: 'body',
      snake: 'snake',
      food: 'food',
      cell: 'cell',
      novisible: 'no-visible'
    },
    direction: {
      left: "left",
      right: "right",
      up: "up",
      down: "down",
    },
    keyCode: {
      left: 97,
      right: 100,
      up: 119,
      down: 115,
      space: 32
    },
    cellSize: 20
  }
})();
