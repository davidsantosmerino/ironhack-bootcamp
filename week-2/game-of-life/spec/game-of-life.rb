require_relative "../lib/game-of-life"

describe GameOfLife do

  describe '#simulate' do
    it "returns a right resultant grid after simulate once" do
      game_of_life = GameOfLife.new
      expected_grid = [
        [0,1,1,0],
        [0,0,0,1],
        [0,0,0,1],
        [0,1,1,0],
      ]
      expect(game_of_life.regenerate).to eq(expected_grid)
    end
  end

end
