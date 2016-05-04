class AddLoserToMatches < ActiveRecord::Migration
  def change
    add_reference :matches, :loser, references: :player, :index => true
  end
end
