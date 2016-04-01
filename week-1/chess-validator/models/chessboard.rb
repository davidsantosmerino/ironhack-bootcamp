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
    x_positions = [start_position[0],end_position[0]]
    y_positions = [start_position[1],end_position[1]]
    if start_position[0] == end_position[0]
      (x_positions.min .. x_positions.max).each do |x|
        (y_positions.min .. y_positions.max).each do |y|
          path << [x,y]
        end
      end
    else
      (y_positions.min .. y_positions.max).each do |y|
        (x_positions.min .. x_positions.max ).each do |x|
          path << [x,y]
        end
      end
    end
    path.delete start_position

    path
  end

  def move_piece piece, position
    @board[position[0]][position[1]] = piece
  end

  def remove_piece position
    @board[position[0]][position[1]] = nil
  end

  def get_piece_by_position position
    @board[position[0]][position[1]]
  end

  def is_a_free_path? positions
    !positions.any? {|position| @board[position[0]][position[1]] != nil}
  end

  def is_an_empty_position? position
    @board[position[0]][position[1]] == nil
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
