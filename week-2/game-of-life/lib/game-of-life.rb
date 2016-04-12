require_relative "constants"
require_relative "cell"

class GameOfLife
  DEFAULT_WIDTH = 20
  DEFAULT_HEIGHT = 20
  LINE_BREAK = "\n"
  ALIVE_PRINT = " * "
  DEAD_PRINT = "   "

  def initialize steps, custom_grid = nil
    @steps = steps
    @grid = custom_grid
  end

  def grid
    @grid ||= random_grid
  end

  def width
    @width ||= grid.first.size
  end

  def height
    @height ||= grid.size
  end

  def random_grid
    new_grid = Array.new(DEFAULT_HEIGHT) { Array.new(DEFAULT_WIDTH) }
    (0..DEFAULT_HEIGHT-1).each do |y|
      (0..DEFAULT_WIDTH-1).each do |x|
        new_grid[x][y] = rand(0..1)
      end
    end

    new_grid
  end

  def simulate
    (0..@steps).each do |i|
      regenerate
      show_grid
    end
  end

  def regenerate
    result_grid = Array.new(height) { Array.new(width) }
    (0..height-1).each do |y|
      (0..width-1).each do |x|
        cell_status = grid[x][y]
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
        if valid_position? cell_x, cell_y, x_position, y_position
          neighbours << @grid[x_position][y_position]
        end
      end
    end

    neighbours
  end

  def valid_position? cell_x, cell_y, x_position, y_position
    valid_x_position?(x_position) &&
    valid_y_position?(y_position) &&
    no_self_cell?(cell_x, cell_y, x_position, y_position)
  end

  def no_self_cell? cell_x, cell_y, x_position, y_position
    (x_position != cell_x || y_position != cell_y)
  end

  def valid_x_position? x_position
    0 <= x_position && x_position < width
  end

  def valid_y_position? y_position
    0 <= y_position && y_position < height
  end

  def show_grid
    system "clear"
    (0..height-1).each do |y|
      (0..width-1).each do |x|
        if grid[x][y] == Constants.alive
          print ALIVE_PRINT
        else
          print DEAD_PRINT
        end
      end
      print LINE_BREAK
    end
    print LINE_BREAK
  end
end
