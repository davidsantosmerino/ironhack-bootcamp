require_relative "lib/game-of-life"

grid =  [
          [0,0,0,0,0],
          [0,0,1,0,0],
          [0,0,1,0,0],
          [0,0,1,0,0],
          [0,0,0,0,0]
        ]
game_of_life = GameOfLife.new 50
game_of_life.simulate
