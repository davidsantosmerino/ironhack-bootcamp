class AddLoserToMatches < ActiveRecord::Migration
  def change
    add_reference :matches, :loser, references: :player
  end
end
