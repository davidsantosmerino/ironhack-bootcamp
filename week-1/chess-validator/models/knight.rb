require "./models/piece"

class Knight < Piece

  def initialize color
    @color = color
  end

  def can_move? chessboard, start_position, end_position
    if ((start_position[0] - end_position[0]).abs == 2) && (start_position[1] - end_position[1]).abs == 1 ||
      ((start_position[0] - end_position[0]).abs == 1) && (start_position[1] - end_position[1]).abs == 2
      path = chessboard.path_to start_position, end_position

      chessboard.is_an_empty_position?(end_position)
    else
      false
    end
  end

end
