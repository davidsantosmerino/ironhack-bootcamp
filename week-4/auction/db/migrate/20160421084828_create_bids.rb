class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.float :amount
      t.references :user, index: true
      t.references :product, index: true

      t.timestamps null: false
    end
  end
end
