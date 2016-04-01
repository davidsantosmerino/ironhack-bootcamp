class Piece

  def initialize color
    @color = color
  end

  def piece_name
    @color + self.class.to_s[0]
  end

end
