require_relative "cell"

class GameOfLife

  def initialize horizontal_size, vertical_size
    @horizontal_size = horizontal_size
    @vertical_size = vertical_size
    create_grid
  end

  def create_grid
    @grid = Array.new(@vertical_size) { Array.new(@horizontal_size) }
    populate_grid
  end

  def populate_grid
    (0..@vertical_size-1).each do |y|
      (0..@horizontal_size-1).each do |x|
        @grid[x][y] = rand(0..1) 
      end
    end
  end

  def simulate number_of_iterations
    (0..number_of_iterations).each do |i|
      regenerate
      show_grid
    end
  end

  def regenerate
    result_grid = Array.new(@vertical_size) { Array.new(@horizontal_size) }
    (0..@vertical_size-1).each do |y|
      (0..@horizontal_size-1).each do |x|
        cell_status = @grid[x][y]
        neighbours = neighbours x, y
        cell = Cell.new cell_status, neighbours
        result_grid[x][y] = cell.regenerate
      end
    end
    @grid = result_grid
  end

  def neighbours cell_x, cell_y
    neighbours = []
    (-1..1).each do |x|
      (-1..1).each do |y|
        x_position = cell_x + x
        y_position = cell_y + y
        if (0 <= x_position && x_position < @horizontal_size) &&
          (0 <= y_position && y_position < @vertical_size) &&
          (x_position != cell_x || y_position != cell_y)
          neighbours << @grid[x_position][y_position]
        end
      end
    end
    neighbours
  end

  def show_grid
    (0..@vertical_size-1).each do |y|
      (0..@horizontal_size-1).each do |x|
        print @grid[x][y]
      end
      print "\n"
    end
    print "\n"
  end

end
