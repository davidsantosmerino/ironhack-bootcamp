class Exit
  attr_reader :direction, :new_space

  def initialize direction, new_space
    @direction = direction
    @new_space = new_space
  end

end
