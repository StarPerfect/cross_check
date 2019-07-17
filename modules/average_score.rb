module AverageScore
  def away_team_goals
    away_team_goals = Hash.new(0)
    @game_teams.each do |team|
        away_team_goals[team.team_id] += team.goals if team.home_or_away == "away"
    end
    away_team_goals
  end

  def home_team_goals
    home_team_goals = Hash.new(0)
    @game_teams.each do |team|
      home_team_goals[team.team_id] += team.goals if team.home_or_away == "home"
    end
    home_team_goals
  end

  def away_team_total_games
    each_total_games = Hash.new(0)
    @game_teams.each do |team|
      each_total_games[team.team_id] += 1 if team.home_or_away == "away"
    end
    each_total_games
  end

  def home_team_total_games
    each_total_games = Hash.new(0)
    @game_teams.each do |team|
      each_total_games[team.team_id] += 1 if team.home_or_away == "home"
    end
    each_total_games
  end

  def away_team_avg_goals_per_game
    goals_hash = away_team_goals
    goals_hash.each do |team, goals|
      goals_hash[team] = (goals.to_f / away_team_total_games[team]).round(3)
    end
    goals_hash
  end

  def home_team_avg_goals_per_game
    goals_hash = home_team_goals
    goals_hash.each do |team, goals|
      goals_hash[team] = (goals.to_f / home_team_total_games[team]).round(3)
    end
    goals_hash
  end

  def highest_scoring_visitor
    highest_away = away_team_avg_goals_per_game.max_by {|team, goal_avg| goal_avg}.first
    @team_info.find { |team| team.team_id == highest_away}.team_name
  end

  def highest_scoring_home_team
    highest_home = home_team_avg_goals_per_game.max_by {|team, goal_avg| goal_avg}.first
    @team_info.find { |team| team.team_id == highest_home}.team_name
  end

  def lowest_scoring_visitor
    lowest_away = away_team_avg_goals_per_game.min_by {|team, goal_avg| goal_avg}.first
    @team_info.find { |team| team.team_id == lowest_away}.team_name
  end

  def lowest_scoring_home_team
    lowest_home = home_team_avg_goals_per_game.min_by {|team, goal_avg| goal_avg}.first
    @team_info.find { |team| team.team_id == lowest_home}.team_name
  end
end
