require "pry"

class Cell
  DEAD = 0
  ALIVE = 1

  def initialize(state, neighbours)
    @state = state
    @neighbours = neighbours
  end

  def regenerate
    case
    when count_alive_neighbours < 2
      @state = 0
    when @state == 1 && (2 <= count_alive_neighbours && count_alive_neighbours <= 3)
      @state = 1
    when count_alive_neighbours == 3
      @state = 1
    when count_alive_neighbours > 3
      @state = 0
    end
    @state
  end

  def count_alive_neighbours
    @neighbours.reduce(0) do |sum, cell|
      if cell == ALIVE
        sum += 1
      else
        sum = sum
      end
    end
  end
end
