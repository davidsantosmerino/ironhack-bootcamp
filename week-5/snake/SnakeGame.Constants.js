(function () {
  window.SnakeGame = window.SnakeGame || {};
  var Constants = window.SnakeGame.Constants = {
    elements: {
      mainContainer: '.main-container',
      pauseContainer: '.pause-container',
      gameOverContainer: '.game-over-container',
      levelUpContainer: '.level-up-container'
    },
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
    gridPercentage: 0.98,
    cellSize: 20
  }
})();
