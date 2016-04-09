require_relative "../lib/cell"

describe Cell do

  describe '#count_alive_neighbours' do
    it "returns 2 if it has 2 neighbours" do
      cell1 = Cell.new(0, [0,1,1,0,0,0,0,0])
      expect(cell1.count_alive_neighbours).to eq(2)
    end
  end

  describe '#count_alive_neighbours' do
    it "returns 0 if it has 0 neighbours" do
      cell1 = Cell.new(0, [0,0,0,0,0,0,0,0])
      expect(cell1.count_alive_neighbours).to eq(0)
    end
  end

  describe '#regenerate' do
    it "regenerates a live cell from a live cell if it has 2 neighbours" do
      cell1 = Cell.new(1, [0,0,0,0,0,0,1,1])
      expect(cell1.regenerate).to eq(1)
    end
  end

  describe '#regenerate' do
    it "regenerates a live cell from a live cell if it has 3 neighbours" do
      cell1 = Cell.new(1, [0,0,0,0,1,0,1,1])
      expect(cell1.regenerate).to eq(1)
    end
  end

  describe '#regenerate' do
    it "regenerates a deade cell from a live cell if it has more than 3 neighbours" do
      cell1 = Cell.new(1, [0,0,0,1,1,0,1,1])
      expect(cell1.regenerate).to eq(0)
    end
  end

  describe '#regenerate' do
    it "regenerates a deade cell from a live cell if it has less than 2 neighbours" do
      cell1 = Cell.new(1, [0,0,0,1,0,0,0,0])
      expect(cell1.regenerate).to eq(0)
    end
  end

  describe '#regenerate' do
    it "regenerates a dead cell from a dead cell if it has 0 neighbours" do
      cell1 = Cell.new(0, [0,0,0,0,0,0,0,0])
      expect(cell1.regenerate).to eq(0)
    end
  end

  describe '#regenerate' do
    it "regenerates a live cell from a dead cell if it has 3 neighbours" do
      cell1 = Cell.new(0, [0,1,1,1,0,0,0,0])
      expect(cell1.regenerate).to eq(1)
    end
  end



end
