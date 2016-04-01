require "./models/piece"

class Queen < Piece

  def initialize color
    @color = color
  end

  def can_move? chessboard, start_position, end_position
    if (start_position[0] - end_position[0]).abs == (start_position[1] - end_position[1]).abs ||
      start_position[0] == end_position[0] || start_position[1] == end_position[1]
      path = chessboard.path_to start_position, end_position

      chessboard.is_an_empty_position?(end_position) &&
        chessboard.is_a_free_path?(path)
    else
      false
    end
  end

end
