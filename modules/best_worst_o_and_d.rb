module BestWorstOAndD
  def method_name
    team_goals = Hash.new(0)
    team_total_games = Hash.new(0)

    @game_teams.each do |team|
      team_goals[team.team_id] += team.goals
      team_total_games[team.team_id] += 1
    end

    team_goals.each do |team, goals|
      team_goals[team] = (goals.to_f / team_total_games[team])
    end


  end

  def team_total_games
    each_total_games = Hash.new(0)
    @game_teams.each { |team| each_total_games[team.team_id] += 1}
    each_total_games
  end
end
