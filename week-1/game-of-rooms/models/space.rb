class Space
  attr_reader :id, :main_message, :exits, :special_action, :objects, :hint

  def initialize id, main_message, exits, special_actions, objects, hint
    @id = id
    @main_message = main_message
    @exits = exits
    @special_actions = special_actions
    @objects = objects
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

  def is_there_any_object? object_type
    object_id = @objects.index{|object| object == object_type}
    object_id ? @objects[object_id] : nil
  end

  def add_object object
    @objects << object
  end

  def remove_object object
    @objects.delete object
  end

end
