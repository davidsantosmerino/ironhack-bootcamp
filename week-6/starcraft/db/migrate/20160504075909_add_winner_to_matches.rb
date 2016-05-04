class AddWinnerToMatches < ActiveRecord::Migration
  def change
    add_reference :matches, :winner, references: :player, :index => true
  end
end
