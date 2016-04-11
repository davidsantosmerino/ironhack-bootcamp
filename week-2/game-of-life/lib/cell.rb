class Cell
  DEAD = 0
  ALIVE = 1

  def initialize(state, neighbours)
    @state = state
    @neighbours = neighbours
  end

  def regenerate
    case @state
    when ALIVE
        return DEAD if under_population? || overcrowding?
    when DEAD
        return ALIVE if reproduction?
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
