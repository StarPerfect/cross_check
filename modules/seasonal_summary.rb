module SeasonalSummary
  def seasonal_summary(team_id)
    all_team_games = @games.find_all{ |game| (game.away_team_id == team_id || game.home_team_id == team_id) }
    games_by_season = all_team_games.group_by do |game|
      game.season
    end
    games_by_season.transform_values! do |games|
      games.group_by{ |game| game.type }
    end
    w = games_by_season.each{ |season, p_or_r| games_by_season[season] = {
      postseason: {
        win_percentage: win_percent(games_by_season[season]['P']),
        total_goals_scored: tot_goals(games_by_season[season]['P']),
        total_goals_against: against_goals(games_by_season[season]['P']),
        average_goals_scored: avg_goals(games_by_season[season]['P']),
        average_goals_against: against_avg(games_by_season[season]['P'])
    },
      regular_season: {
        win_percentage: win_percent(games_by_season[season]['R']),
        total_goals_scored: tot_goals(games_by_season[season]['R']),
        total_goals_against: against_goals(games_by_season[season]['R']),
        average_goals_scored: avg_goals(games_by_season[season]['R']),
        average_goals_against: against_avg(games_by_season[season]['R'])
        }}}
require 'pry'; binding.pry
  end

  def win_percent(games)
  end

  def tot_goals(games)
  end

  def against_goals(games)
  end

  def avg_goals(games)
  end

  def against_avg(games)
  end
end
