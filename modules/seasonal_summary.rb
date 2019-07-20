module SeasonalSummary
  def seasonal_summary(team_id)
    all_team_games = @games.find_all{ |game| (game.away_team_id == team_id || game.home_team_id == team_id) }
    games_by_season = Hash.new
    all_team_games.each{ |game| games_by_season[game.season] = {postseason: {}, regular_season: {}}}
    
require 'pry'; binding.pry
  end
end
