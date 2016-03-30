require "./controllers/situation-manager"

class Game

  GAME_OVER = "GAME OVER"

  def initialize spaces, character
    @situation_manager = SituationManager.new spaces, character
  end

  def start
    puts ">"
    while(not @situation_manager.game_over)
      @situation_manager.move_character
    end
    puts GAME_OVER
  end

end
