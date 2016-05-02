class Sandwich < ActiveRecord::Base
  has_many :sandwich_ingredients
  has_many :ingredients,
            through: :sandwich_ingredients,
            after_add: :increase_calories,
            after_remove: :decrease_calories
  validates :name, presence: true, length: {minimum: 3, maximum: 100}

  private
  def increase_calories ingredient
    self.total_calories += ingredient.calories
    self.save
  end
  def decrease_calories ingredient
    self.total_calories -= ingredient.calories
    self.save
  end
end
