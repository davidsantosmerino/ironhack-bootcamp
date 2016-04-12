require_relative "constants"

class Cell
  def initialize(state, neighbours)
    @state = state
    @neighbours = neighbours
  end

  def regenerate
    case @state
    when Constants.alive
        return Constants.dead if under_population? || overcrowding?
    when Constants.dead
        return Constants.alive if reproduction?
    end
    return @state
  end

  def under_population?
    count_alive_neighbours < 2
  end

  def reproduction?
    count_alive_neighbours == 3
  end

  def overcrowding?
    count_alive_neighbours > 3
  end

  def count_alive_neighbours
    @count_alive_neighbours ||= @neighbours.reduce(0) {|sum, cell| sum += cell}
  end
end
