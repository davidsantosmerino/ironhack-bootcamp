require "./models/piece"

class Rook < Piece

  def initialize color
    @color = color
  end

  def can_move? chessboard, start_position, end_position
    if start_position[:x] == end_position[:x] || start_position[:y] == end_position[:y]
      path = chessboard.path_to start_position, end_position

      chessboard.is_an_empty_position?(end_position) &&
        chessboard.is_a_free_path?(path)
    else
      false
    end
  end

end
