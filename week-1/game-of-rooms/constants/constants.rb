module Constants

  def self.inventory
    "INVENTORY"
  end

  def self.exit
    "EXIT"
  end

  def self.object_types
    {
      sword: "SWORD",
      lens: "LENS"
    }
  end

  def self.direction_types
    {
      N: "N",
      E: "E",
      W: "W",
      S: "S"
    }
  end

  def self.action_object_types
    {
      pick_up: "PICK UP",
      drop: "DROP"
    }
  end

  def self.action_types
    {
      fire: "FIRE",
      look_food: "LOOK FOOD"
    }
  end

end
