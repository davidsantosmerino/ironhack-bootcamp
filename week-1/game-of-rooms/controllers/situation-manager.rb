require 'pry'
Dir["./constants/*"].each {|file| require file }

class SituationManager
  attr_reader :game_over
  NO_EXIT = "There is no exit there"
  NO_HAVE_OBJECT = "You don't have the object that are dropping!"
  NO_OBJECT = "There is no object required"
  NO_RESULT = "Nothing has happened"
  BYE_MESSAGE = "Okey, see you soon! Bye!"

  def initialize spaces, character
    @spaces = spaces
    @character = character
    @game_over = false
  end

  def move_character
    input = gets.chomp.upcase
      current_space = find_space_by_id(@spaces, @character.current_space)
      if is_a_direction? input
        move current_space, input
      elsif is_an_action? input
        do_special_action current_space, input
      elsif is_an_object_action? input
        do_object_action current_space, input
      elsif input == Constants.inventory
        @character.inventory.show
      elsif input == Constants.exit
        puts BYE_MESSAGE
        @game_over = true
      else
        puts "Type a correct input, please"
      end
      puts "#{@character.current_space}>"
  end

  def find_space_by_id spaces, id
    space_index = spaces.index{|space| space.id == id}
    spaces[space_index]
  end

  def is_an_action? input
    Constants.action_types.rassoc(input)
  end

  def is_a_direction? input
    Constants.direction_types.rassoc(input)
  end

  def is_an_object_action? input
    Constants.action_object_types.any? { |key, value| input.include? value }
  end

  def do_object_action current_space, action_object
    action_object_type = nil
    Constants.action_object_types.each do |key, value|
      action_object_type = value if action_object.include? value
    end
    action_object = extract_object_from_input action_object, action_object_type
    case action_object_type
    when Constants.action_object_types[:pick_up]
      if current_space.is_there_any_object? action_object
        if @character.pick_up_object action_object
          current_space.remove_object action_object
          puts "A #{action_object} was added"
        else
          puts "Could not add #{action_object}! Check if it's already in your inventory."
        end
      else
        puts NO_OBJECT
      end
    when Constants.action_object_types[:drop]
        if @character.drop_object action_object
          current_space.add_object action_object
          puts "A #{action_object} was dropped"
        else
          puts NO_HAVE_OBJECT
        end
    end
  end

  def extract_object_from_input input, text_to_slice
    input.slice! text_to_slice
    input.lstrip.chomp
  end

  def move current_space, direction
    exit = current_space.is_an_exit_point? direction
    if exit
      @character.current_space = exit.new_space
      current_space = find_space_by_id(@spaces, @character.current_space)
      puts current_space.main_message
    else
      puts NO_EXIT
      puts current_space.hint
    end
    puts "Exits: #{all_space_exits current_space }"
  end

  def do_special_action current_space, special_action
    special_result = current_space.is_a_special_action? special_action
    if special_result
      puts special_result.result_type
      @game_over =  true if special_result.game_over
    else
      puts NO_RESULT
      puts current_space.hint
    end
  end

  def all_space_exits current_space
    all_exits = current_space.exits.map { |exit| exit.direction  }
    all_exits.join ", "
  end

end
