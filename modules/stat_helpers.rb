module StatHelpers
  def get_team_name(id)
    @teams.find { |team| team.team_id == id }.team_name
  end

  def get_team_id_from_name(name)
  @teams.find{ |team| team.team_name == name }.team_id
  end

  def team_total_games_from_games
    each_total_games = Hash.new(0)
    @game_teams.each { |game_team| each_total_games[game_team.team_id] += 1}
    each_total_games
  end

  def team_total_games_from_games_teams
    each_total_games = Hash.new(0)
    @games.each do |game|
      each_total_games[game.home_team_id] += 1
      each_total_games[game.away_team_id] += 1
    end
    each_total_games
  end
end
