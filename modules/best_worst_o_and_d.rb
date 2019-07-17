module BestWorstOAndD
  def team_total_games
    each_total_games = Hash.new(0)
    @game_teams.each { |team| each_total_games[team.team_id] += 1}
    each_total_games
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
    best_o = team_avg_goals_per_game.max_by {|team, goal_avg| goal_avg}.first
    @team_info.find { |team| team.team_id == best_o}.team_name
  end

  def worst_offense
    worst_o = team_avg_goals_per_game.min_by {|team, goal_avg| goal_avg}.first
    @team_info.find { |team| team.team_id == worst_o}.team_name
  end

end
