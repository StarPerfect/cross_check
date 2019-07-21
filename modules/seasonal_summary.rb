module SeasonalSummary
  def seasonal_summary(id)
    all_team_games = @games.find_all{ |game| (game.away_team_id == id || game.home_team_id == id) }
    games_by_season = all_team_games.group_by do |game|
      game.season
    end
    games_by_season.transform_values! do |games|
      games.group_by{ |game| game.type }
    end
    games_by_season.each{ |season, p_or_r| games_by_season[season] = {
      postseason: {
        win_percentage: win_percent(games_by_season[season]['P'], id),
        total_goals_scored: tot_goals(games_by_season[season]['P'], id),
        total_goals_against: against_goals(games_by_season[season]['P'], id),
        average_goals_scored: avg_goals(games_by_season[season]['P'], id),
        average_goals_against: against_avg(games_by_season[season]['P'], id)
    },
      regular_season: {
        win_percentage: win_percent(games_by_season[season]['R'], id),
        total_goals_scored: tot_goals(games_by_season[season]['R'], id),
        total_goals_against: against_goals(games_by_season[season]['R'], id),
        average_goals_scored: avg_goals(games_by_season[season]['R'], id),
        average_goals_against: against_avg(games_by_season[season]['R'], id)
        }
      }
    }

  end

  def win_percent(games, id)
    wins = games.count do |game|
      if game.away_team_id == id
        game.away_goals > game.home_goals
      else
        game.home_goals > game.away_goals
      end
    end
    ( wins.to_f / games.length )
    .round(2)
  end

  def tot_goals(games, id)
    games.sum do |game|
      if game.away_team_id == id
        game.away_goals
      else
        game.home_goals
      end
    end
  end

  def against_goals(games, id)
    games.sum do |game|
      if game.away_team_id == id
        game.home_goals
      else
        game.away_goals
      end
    end
  end

  def avg_goals(games, id)
    ( tot_goals(games, id).to_f / games.length )
    .round(2)
  end

  def against_avg(games, id)
  ( against_goals(games, id).to_f / games.length )
  .round(2)
  end
end
