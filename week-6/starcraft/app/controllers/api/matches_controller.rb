class Api::MatchesController < ApplicationController
  def index
    matches = Match.all
    render json: matches
  end
  def by_faction
    faction = params[:faction]
    winner_matches = Match.where(
      "winner_faction = ?",
      faction
    )
    matches = Match.where(
      "winner_faction = ? OR loser_faction = ?",
      faction,
      faction
    )
    win_percentage = (winner_matches.count / matches.count.to_f) * 100

    render json: { matches: matches, win_percentage: win_percentage}
  end
end
