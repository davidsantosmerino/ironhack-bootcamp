class AddMinBidToProducts < ActiveRecord::Migration
  def change
    add_column :products, :min_bid, :int
  end
end
