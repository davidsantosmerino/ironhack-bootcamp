class AddAmountToIngredients < ActiveRecord::Migration
  def change
    add_column :ingredients, :amount, :float
  end
end
