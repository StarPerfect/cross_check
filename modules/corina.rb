module Corina
  def count_of_teams
    @team_info.count
  end

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

  def winningest_team
    wins_per_team.each do |team, wins|
      wins_per_team[team] = (wins.to_i / team_total_games[team])
    end
    answer = wins_per_team.max_by{ |key, value| value }
    @team_info.find{ |team| team.team_id == answer[0] }.teamname
  end

end
