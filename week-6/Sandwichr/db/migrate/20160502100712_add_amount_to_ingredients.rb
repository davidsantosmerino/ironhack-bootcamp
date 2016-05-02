class AddAmountToIngredients < ActiveRecord::Migration
  def change
    add_column :ingredients, :amount, :float, default: 0
  end
end
