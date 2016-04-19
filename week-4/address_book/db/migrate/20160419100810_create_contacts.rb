class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.text :address
      t.string :phone
      t.string :email, unique: true
      t.boolean :fav

      t.timestamps null: false
    end
  end
end
