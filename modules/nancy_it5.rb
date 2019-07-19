module NancyIt5

  def total_games_per_season(season)
    game_ids = []
    games.select { |g| game_ids << g.game_id if g.season == season }
    game_teams.select { |g| game_ids.include? g.game_id }
  end

  def team_wins_per_season(season)
    hash = Hash.new(0)
    total_games_per_season(season).each do |g|
      hash[g.team_id] += 1 if g.won == TRUE
    end
    hash
  end

  def team_total_games_per_season(season)
    hash = Hash.new(0)
    games.select { |g| g.season == season }.each do |g|
      hash[g.away_team_id] += 1
      hash[g.home_team_id] += 1
    end
    hash
  end

  def win_percentage_per_season(season)
    wins = team_wins_per_season(season)
    totals = team_total_games_per_season(season)

    totals.each do |season, total|
      totals[season] = (wins[season] / total.to_f * 100).round(2)
    end
    totals
  end

  def winningest_coach(season)
    team_id = win_percentage_per_season(season).max_by {|k,v| v}[0]
    total_games_per_season(season).find { |team| team.team_id == team_id }
      .head_coach
  end

  def worst_coach(season)
    team_id = win_percentage_per_season(season).min_by {|k,v| v}[0]
    total_games_per_season(season).find { |team| team.team_id == team_id }
      .head_coach
  end

  def team_total_shots_per_season(season)
    hash = Hash.new(0)
    total_games_per_season(season).each do |g|
      hash[g.team_id] += g.shots
    end
    hash
  end

  def team_total_goals_per_season(season)
    hash = Hash.new(0)
    total_games_per_season(season).each do |g|
      hash[g.team_id] += g.goals
    end
    hash
  end

  def shot_goal_ratio_per_team_per_season(season)
    shots = team_total_shots_per_season(season)
    goals = team_total_goals_per_season(season)

    goals.each do |season, goal|
      goals[season] = (shots[season] / goal.to_f).round(2)
    end
    goals
  end

  def most_accurate_team(season)
    team_id = shot_goal_ratio_per_team_per_season(season).max_by {|k,v| v}[0]
    teams.find { |team| team.team_id == team_id }.team_name
  end

  def least_accurate_team(season)
    team_id = shot_goal_ratio_per_team_per_season(season).min_by {|k,v| v}[0]
    teams.find { |team| team.team_id == team_id }.team_name
  end

end
