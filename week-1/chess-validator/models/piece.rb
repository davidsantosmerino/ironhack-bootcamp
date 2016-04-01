class Piece

  def initialize color
    @color = color
  end

  def piece_name
    @color + self.class.to_s.first
  end

end
