class SpecialAction
  attr_reader :action_type, :result_type, :game_over

  def initialize action_type, result_type, game_over = false
    @action_type = action_type
    @result_type = result_type
    @game_over = game_over
  end

end
