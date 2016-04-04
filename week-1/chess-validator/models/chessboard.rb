Dir["./models/*"].each {|file| require file }
class ChessBoard

  def initialize
    @board = [
      [Rook.new("b"), Knight.new("b"), Bishop.new("b"), Queen.new("b"), King.new("b"), Bishop.new("b"), Knight.new("b"), Rook.new("b")],
      [Pawn.new("b"), Pawn.new("b"), Pawn.new("b"), Pawn.new("b"), Pawn.new("b"), Pawn.new("b"), Pawn.new("b"), Pawn.new("b")],
      [nil, nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil, nil],
      [Pawn.new("w"), Pawn.new("w"), Pawn.new("w"), Pawn.new("w"), Pawn.new("w"), Pawn.new("w"), Pawn.new("w"), Pawn.new("w")],
      [Rook.new("w"), Knight.new("w"),  Bishop.new("w"), Queen.new("w"), King.new("w"), Bishop.new("w"), Knight.new("w"), Rook.new("w")]
    ]
  end

  def path_to start_position, end_position
    path = []
    x_positions = [start_position[:x], end_position[:x]]
    y_positions = [start_position[:y], end_position[:y]]
    if is_vertical_movement? start_position, end_position
      path = vertical_path x_positions, y_positions
    elsif is_horizontal_movement? start_position, end_position
      path = horizontal_path x_positions, y_positions
    elsif is_diagonal_movement? start_position, end_position
      path = diagonal_path x_positions, y_positions
    end
    path.delete start_position
    path
  end

  def vertical_path x_positions, y_positions
    path = []
    (x_positions.min .. x_positions.max).each do |x|
      (y_positions.min .. y_positions.max).each do |y|
        path << {:x => x,:y => y}
      end
    end
    path
  end

  def horizontal_path x_positions, y_positions
    path = []
    (y_positions.min .. y_positions.max).each do |y|
      (x_positions.min .. x_positions.max ).each do |x|
        path << {:x => x,:y => y}
      end
    end
    path
  end

  def diagonal_path x_positions, y_positions
    path = []
    x_min = x_positions.min
    distance = x_positions.max - x_positions.min - 1
    y_min = y_positions.min
    1.upto(distance) do |increment|
      path << {:x => x_min + increment , :y => y_min + increment }
    end
    path
  end

  def is_horizontal_movement? start_position, end_position
    start_position[:y] == end_position[:y]
  end

  def is_vertical_movement? start_position, end_position
    start_position[:x] == end_position[:x]
  end

  def is_diagonal_movement? start_position, end_position
    (start_position[:x] - end_position[:x]).abs ==
    (start_position[:y] - end_position[:y]).abs
  end

  def move_piece piece, position
    @board[position[:x]][position[:y]] = piece
  end

  def remove_piece position
    @board[position[:x]][position[:y]] = nil
  end

  def get_piece_by_position position
    @board[position[:x]][position[:y]]
  end

  def is_a_free_path? positions
    !positions.any? {|position| @board[position[:x]][position[:y]] != nil}
  end

  def is_an_empty_position? position
    @board[position[:x]][position[:y]] == nil
  end

  def draw
    @board.each do |row|
      row.each do |piece|
        if piece
          print piece.piece_name
        else
          print "--"
        end
      end
      puts "\n"
    end
  end

end
