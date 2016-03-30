require "./models/inventory"

class Character
  attr_accessor :current_space, :inventory

  def initialize inventory = Inventory.new
    @current_space = 0
    @inventory = inventory
  end

  def pick_up_object object
    @inventory.add_object object
  end

  def drop_object object
    @inventory.remove_object object
  end

end
