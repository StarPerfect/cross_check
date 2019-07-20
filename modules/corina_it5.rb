module CorinaIt5
  def most_hits(season)
    game_ids_in_season = @games.find_all{ |game| game.season == season }.map{ |game_id| game_id.game_id }
    game_teams_in_season = @game_teams.find_all{ |game_team| game_team.game_id.include? game_team.game_id }
    hits_hash = Hash.new(0)
    game_teams_in_season.each{ |game_team| hits_hash[game_team.team_id] += game_team.hits }
    most_hits_team = hits_hash.max_by{ |key,value| value }.first
    get_team_name(most_hits_team)
  end

  def fewest_hits(season)
    game_ids_in_season = @games.find_all{ |game| game.season == season }.map{ |game_id| game_id.game_id }
    game_teams_in_season = @game_teams.find_all{ |game_team| game_team.game_id.include? game_team.game_id }
    hits_hash = Hash.new(0)
    game_teams_in_season.each{ |game_team| hits_hash[game_team.team_id] += game_team.hits }
    fewest_hits_team = hits_hash.min_by{ |key,value| value }.first
    get_team_name(fewest_hits_team)
  end

  def power_play_goal_percentage(season)
    game_ids_in_season = @games.find_all{ |game| game.season == season }.map{ |game_id| game_id.game_id }
    game_teams_in_season = @game_teams.find_all{ |game_team| game_team.game_id.include? game_team.game_id }
    total_goals = game_teams_in_season.map{ |game_team| game_team.goals }.sum
    total_pp_goals = game_teams_in_season.map{ |game_team| game_team.power_play_goals }.sum
    percentage = total_pp_goals.to_f / total_goals
    percentage.round(2)
  end
end
