module CorinaIt5
  def most_hits(season)
    game_ids = @games.find_all { |game| game.season == season }.map{|game_id| game_id.game_id}
    game_teams_in_season = @game_teams.find_all do |game_team|
      game_ids.include? game_team.game_id
    end
    hits_hash = Hash.new(0)
    game_teams_in_season.each do |game_team|
      hits_hash[game_team.team_id] += game_team.hits
    end
    most_hits_team = hits_hash.max_by{|key,value| value}.first
    get_team_name(most_hits_team)
  end

  def fewest_hits(season)
    game_ids = @games.find_all { |game| game.season == season }.map{|game_id| game_id.game_id}
    game_teams_in_season = @game_teams.find_all do |game_team|
      game_ids.include? game_team.game_id
    end
    hits_hash = Hash.new(0)
    game_teams_in_season.each do |game_team|
      hits_hash[game_team.team_id] += game_team.hits
    end
    fewest_hits_team = hits_hash.min_by{|key,value| value}.first
    get_team_name(fewest_hits_team)
  end
end
