module SeasonalSummary
  def seasonal_summary(id)
    by_season_and_type = @games.find_all { |game| (game.away_team_id == id || game.home_team_id == id) }
      .group_by { |game| game.season }
      .transform_values! { |games| games.group_by{|game| game.type} }

    by_season_and_type.each do |season, p_or_r|
      by_season_and_type[season] = {
        postseason: get_stats(by_season_and_type[season]['P'], id),
        regular_season: get_stats(by_season_and_type[season]['R'], id)
      }
    end
  end

  def get_stats(games, id)
    { win_percentage: win_percent(games, id),
      total_goals_scored: tot_goals(games, id),
      total_goals_against: against_goals(games, id),
      average_goals_scored: avg_goals(games, id),
      average_goals_against: against_avg(games, id)
    }
  end

  def win_percent(games, id)
    return 0.0 if games.nil?
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
    return 0 if games.nil?
    games.sum do |game|
      game.away_team_id == id ? game.away_goals : game.home_goals
    end
  end

  def against_goals(games, id)
    return 0 if games.nil?
    games.sum do |game|
      game.away_team_id == id ? game.home_goals : game.away_goals
    end
  end

  def avg_goals(games, id)
    return 0.0 if games.nil?
    ( tot_goals(games, id).to_f / games.length )
    .round(2)
  end

  def against_avg(games, id)
    return 0.0 if games.nil?
    ( against_goals(games, id).to_f / games.length )
    .round(2)
  end
end
