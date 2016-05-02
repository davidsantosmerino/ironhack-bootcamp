class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.string :name
      t.integer :calories, default: 0

      t.timestamps
    end
  end
end
