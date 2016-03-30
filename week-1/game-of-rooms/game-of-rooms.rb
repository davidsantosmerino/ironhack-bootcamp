require 'pry'

#Global vars
$direction_types = { N: "N", E: "E", W: "W", S: "S" }
$action_types = { fire: "FIRE", look_food: "LOOK FOOD" }
$result_types = { bear_wakes: "The bear wakes up and kills you.", find_food: "You've found some food!" }

class Utils

  def self.find_space_by_id spaces, id
    space_index = spaces.index{|space| space.id == id}
    spaces[space_index]
  end

end

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

class SituationManager

  attr_reader :game_over

  NO_EXIT = "There is no exit there"
  NO_RESULT = "Nothing has happened"

  def initialize spaces, character
    @spaces = spaces
    @character = character
    @game_over = false
  end

  def move_character 
    input = gets.chomp.upcase
      current_space = Utils.find_space_by_id(@spaces, @character.current_space)
      if is_a_direction? input 
        exit = current_space.is_an_exit_point? input
        if exit
          @character.current_space = exit.new_space
          current_space = Utils.find_space_by_id(@spaces, @character.current_space)
          puts current_space.main_message
        else
          puts NO_EXIT
          puts current_space.hint
        end
      elsif is_an_action? input
        special_result = current_space.is_a_special_action? input
        if special_result
          puts special_result.result_type
          @game_over = special_result.game_over ? true : false
        else
          puts NO_RESULT
          puts current_space.hint
        end
      else
        puts "Type a correct input, please"
      end
      puts "#{@character.current_space}>"
  end

  def is_an_action? input
    $action_types.rassoc(input)    
  end

  def is_a_direction? input
    $direction_types.rassoc(input)  
  end

end

class Character
  attr_accessor :current_space

  def initialize
    @current_space = 0
  end

  def move direction

  end

end

class Space
  attr_reader :id, :main_message, :exits, :special_action, :hint

  def initialize id, main_message, exits, special_actions, hint
    @id = id
    @main_message = main_message
    @exits = exits
    @special_actions = special_actions
    @hint = hint
  end

  def is_an_exit_point? direction
    exit_id = @exits.index{|exit| exit.direction == direction}
    exit_id ? @exits[exit_id] : nil
  end

  def is_a_special_action? action_type
    special_action_id = @special_actions.index{|special_action| special_action.action_type == action_type }
    special_action_id ? @special_actions[special_action_id] : nil
  end

end

class Exit
  attr_reader :direction, :new_space

  def initialize direction, new_space
    @direction = direction
    @new_space = new_space
  end

end

class SpecialAction
  attr_reader :action_type, :result_type, :game_over

  def initialize action_type, result_type, game_over = false
    @action_type = action_type
    @result_type = result_type
    @game_over = game_over
  end

end

#Special actions
find_food = SpecialAction.new($action_types[:look_food], $result_types[:find_food])
bear_wakes = SpecialAction.new($action_types[:fire], $result_types[:bear_wakes], true)
#Exits
exits0 = [Exit.new($direction_types[:E],1)]
exits1 = [Exit.new($direction_types[:W],0), Exit.new($direction_types[:S],2)]
exits2 = [Exit.new($direction_types[:N],1), Exit.new($direction_types[:S],3)]
exits3 = [Exit.new($direction_types[:N],2), Exit.new($direction_types[:E],4)]
exits4 = [Exit.new($direction_types[:W],3)]
#Spaces
space0 = Space.new 0, "You are in the forest. There is a lot of light. There is a bear sleeping.", exits0, [find_food], "You are in a dark room. There is a door at the east."
space1 = Space.new 1, "You are close to a lake.", exits1, [bear_wakes], "You are in a dark room. There is a door at the south."
space2 = Space.new 2, "You are close to a lake2.", exits2, [], "You are in a dark room. There is a door at the north."
space3 = Space.new 3, "You are close to a lake3.", exits3, [], "You are in a dark room. There is a door at the north."
space4 = Space.new 4, "You are close to a lake3.", exits4, [], "You are in a dark room. There is a door at the north."
#Character
character0 = Character.new
#Game
game = Game.new [space0, space1, space2, space3, space4], character0

game.start

