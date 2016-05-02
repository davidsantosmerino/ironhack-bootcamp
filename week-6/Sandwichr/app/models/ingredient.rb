class Ingredient < ActiveRecord::Base
  has_many :sandwich_ingredients
  has_many :sandwiches, through: :sandwich_ingredients
  validates :name, presence: true, length: {minimum: 3, maximum: 100}
  validates :calories, numericality: { only_integer: true, greater_than: 0 }
  validates :amount, numericality: {greater_than: 0 }
end
