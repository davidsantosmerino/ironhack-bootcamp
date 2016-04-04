require "./models/chessboard"

class ChessValidator

  def initialize
    @chessboard = ChessBoard.new
    @movements = []
    set_chess_validator_ready
    check_movements
  end

  def set_chess_validator_ready
    get_movements
  end

  def get_movements
    movements_file = "movements.txt"
    raw_movements = IO.readlines movements_file
    @movements = raw_movements.map { |movement| movement.split }
  end

  def make_movement piece, start_position, end_position
    piece = @chessboard.get_piece_by_position start_position
    @chessboard.move_piece piece, end_position
    @chessboard.remove_piece start_position
  end

  def check_movement movement
    start_position = movement_parser movement[0]
    end_position = movement_parser movement[1]
    piece = @chessboard.get_piece_by_position start_position
    if piece
      if piece.can_move? @chessboard, start_position, end_position
        puts "LEGAL"
      else
        puts "ILLEGAL"
      end
    else
      puts "ANY PIECE IN THIS POSITION"
    end

  end

  def check_movements
     @movements.each{|movement| check_movement movement }
  end

  def movement_parser unparsed_movement
    parsed = {
      :x => 0,
      :y => 0
    }
    parsed_movement = [2]
    board_positions = {
      :a => 0,
      :b => 1,
      :c => 2,
      :d => 3,
      :e => 4,
      :f => 5,
      :g => 6,
      :h => 7,
      1.to_s.to_sym => 7,
      2.to_s.to_sym => 6,
      3.to_s.to_sym => 5,
      4.to_s.to_sym => 4,
      5.to_s.to_sym => 3,
      6.to_s.to_sym => 2,
      7.to_s.to_sym => 1,
      8.to_s.to_sym => 0
    }
    parsed[:x] = board_positions[unparsed_movement[1].to_s.to_sym]
    parsed[:y] =  board_positions[unparsed_movement[0].to_sym]
    parsed
  end

end
