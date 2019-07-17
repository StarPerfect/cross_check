module BestWorstOAndD
  def best_offense
    team_goals = Hash.new(0)

    @game_teams.each do |team|
      team_goals[team.team_id] += team.goals
    end

    team_goals.each do |team, goals|
      team_goals[team] = (goals.to_f / team_total_games[team])
    end

    best_o = team_goals.max_by {|team, goal_avg| goal_avg}.first
    @team_info.find { |team| team.team_id == best_o}.team_name
  end

  def team_total_games
    each_total_games = Hash.new(0)
    @game_teams.each { |team| each_total_games[team.team_id] += 1}
    each_total_games
  end
end
