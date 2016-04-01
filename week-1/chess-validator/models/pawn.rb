require "./models/piece"

class Pawn < Piece

  def initialize color
    @color = color
    @first_movement = true
  end

  def can_move? chessboard, start_position, end_position
    if ((start_position[:x] - end_position[:x]).abs <= 1) ||
      (@first_movement && (start_position[:x] - end_position[:x]).abs <= 2)
      path = chessboard.path_to start_position, end_position

      chessboard.is_an_empty_position?(end_position) &&
        chessboard.is_a_free_path?(path)
    else
      false
    end
  end

end
