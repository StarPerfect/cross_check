module It4Nancy
  def team_total_games
    each_total_games = Hash.new(0)
    @game_teams.each { |team| each_total_games[team.team_id] += 1}
    each_total_games
  end

  def wins_per_team
    team_wins = Hash.new(0)
    @game_teams.each do |team|
      if team.won
       team_wins[team.team_id] += 1
      end
    end
    team_wins
  end

  def team_info(id)
    hash = {}
    team = @team_info.select { |t| t.team_id == id }
    team.instance_variables.each {|var| hash[var.to_s.delete("@")] = team.instance_variable_get(var) }
    hash
  end

  def best_season(id)
    wins_per_team.each do |team, wins|
     wins_per_team[team] = (wins.to_i / team_total_games[team])
    end

    answer = wins_per_team.max_by{ |key, value| value }
    answer
    @games.find{ |team| team.team_id == answer[0] }.season
  end
end
