module BestWorstOAndD
  def team_total_games
    each_total_games = Hash.new(0)
    @game_teams.each { |game_team| each_total_games[game_team.team_id] += 1}
    each_total_games
  end

  def team_total_games_2
    each_total_games = Hash.new(0)
    @games.each do |game|
      each_total_games[game.home_team_id] += 1
      each_total_games[game.away_team_id] += 1
    end
    each_total_games
  end

  def get_team_name(id)
    @team_info.find { |team| team.team_id == id }.team_name
  end

  def team_total_goals
    team_goals = Hash.new(0)
    @game_teams.each { |team| team_goals[team.team_id] += team.goals }
    team_goals
  end

  def team_avg_goals_per_game
    goals_hash = team_total_goals
    goals_hash.each do |team, goals|
      goals_hash[team] = (goals.to_f / team_total_games[team]).round(3)
    end
    goals_hash
  end

  def best_offense
    best_o_id = team_avg_goals_per_game.max_by {|team, goal_avg| goal_avg}.first
    get_team_name(best_o_id)
  end

  def worst_offense
    worst_o_id = team_avg_goals_per_game.min_by {|team, goal_avg| goal_avg}.first
    get_team_name(worst_o_id)
  end

  def team_home_goals_allowed
    home_goals_allowed = Hash.new(0)
    @games.each { |game| home_goals_allowed[game.home_team_id] += game.away_goals}
    home_goals_allowed
  end

  def team_away_goals_allowed
    away_goals_allowed = Hash.new(0)
    @games.each { |game| away_goals_allowed[game.away_team_id] += game.home_goals}
    away_goals_allowed
  end

  def team_avg_goals_allowed
    team_avg_goals = Hash.new
    team_home_goals_allowed.each do |team, goals|
      total_goals = goals + team_away_goals_allowed[team]
      team_avg_goals[team] = total_goals.to_f / team_total_games_2[team]
    end
    team_avg_goals
  end

  def best_defense
    best_d_id = team_avg_goals_allowed.min_by { |team, avg_goals| avg_goals }.first
    get_team_name(best_d_id)
  end

  def worst_defense
    worst_d_id = team_avg_goals_allowed.max_by { |team, avg_goals| avg_goals }.first
    get_team_name(worst_d_id)
  end
end
