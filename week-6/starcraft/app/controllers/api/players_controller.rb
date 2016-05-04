class Api::PlayersController < ApplicationController
  def show
    player_id = params[:id]
    winner_matches = Match.where("winner_id = ?", player_id)
    matches = Match.where("winner_id = ? OR loser_id = ?", player_id, player_id)
    win_percentage = (winner_matches.count / matches.count.to_f) * 100
    lose_percentage = 100 - win_percentage
    render json: { matches: matches, percentage: {win: win_percentage, lose: lose_percentage} }
  end
end
