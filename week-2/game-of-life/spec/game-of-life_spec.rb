require_relative "../lib/game-of-life"

describe GameOfLife do

  describe '#regenerate' do
    it "returns the same grid for the specific pattern" do
      grid =  [
                [0,0,0,0,0],
                [0,1,1,0,0],
                [0,1,1,0,0],
                [0,0,0,0,0],
                [0,0,0,0,0]
              ]
      game_of_life = GameOfLife.new 1, grid
      expect(game_of_life.regenerate).to eq(grid)
    end
  end

  describe '#regenerate' do
    it "returns an oscillation for the specific pattern" do
      grid =  [
                [0,0,0,0,0],
                [0,0,1,0,0],
                [0,0,1,0,0],
                [0,0,1,0,0],
                [0,0,0,0,0]
              ]
      expected_grid =  [
                [0,0,0,0,0],
                [0,0,0,0,0],
                [0,1,1,1,0],
                [0,0,0,0,0],
                [0,0,0,0,0]
              ]
      game_of_life = GameOfLife.new 5, grid
      expect(game_of_life.regenerate).to eq(expected_grid)
    end
  end

end
