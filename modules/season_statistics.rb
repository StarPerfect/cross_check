module SeasonStatistics
  def win_percent_by_type(season)
    this_season = @games.select { |game| game.season == season }
    regular = {}
    playoffs = {}
    this_season.each do |game|
      if game.type == 'R'
        regular[game.away_team_id] = {total: 0, wins: 0} unless regular.key? game.away_team_id
        regular[game.home_team_id] = {total: 0, wins: 0} unless regular.key? game.home_team_id
        regular[game.away_team_id][:total] += 1
        regular[game.home_team_id][:total] += 1
        regular[game.away_team_id][:wins] += 1 if game.away_goals > game.home_goals
        regular[game.home_team_id][:wins] += 1 if game.home_goals > game.away_goals
      else
        playoffs[game.away_team_id] = {total: 0, wins: 0} unless playoffs.key? game.away_team_id
        playoffs[game.home_team_id] = {total: 0, wins: 0} unless playoffs.key? game.home_team_id
        playoffs[game.away_team_id][:total] += 1
        playoffs[game.home_team_id][:total] += 1
        playoffs[game.away_team_id][:wins] += 1 if game.away_goals > game.home_goals
        playoffs[game.home_team_id][:wins] += 1 if game.home_goals > game.away_goals
      end
    end
    {regular_season: regular, playoff_games: playoffs}
  end

  def postseason_change(season)
    totals = win_percent_by_type(season)
    percents = {}
    totals.each do |season_type, teams|
      percents[season_type] = {}
      teams.each do |team, values|
        percents[season_type][team] = values[:wins] / values[:total].to_f
      end
    end
    reg = percents[:regular_season]
    post = percents[:playoff_games]
    post.each do |team, percent|
      # require 'pry';binding.pry #should work with real data
      post[team] = percent - reg[team]
    end
    post
  end

  def biggest_bust(season)
    get_team_name( postseason_change(season).min_by { |team, diff| diff }.first )
  end

  def biggest_surprise(season)
    get_team_name( postseason_change(season).max_by { |team, diff| diff }.first )
  end

  def games_in_season(season)
    game_ids = []
    @games.select { |g| game_ids << g.game_id if g.season == season }
    @game_teams.select { |g| game_ids.include? g.game_id }
  end
  #
  # def team_wins_per_season(season)
  #   hash = Hash.new(0)
  #   total_games_per_season(season).each do |g|
  #     hash[g.team_id] += 1 if g.won == TRUE
  #   end
  #   hash
  # end
  #
  # def team_total_games_per_season(season)
  #   hash = Hash.new(0)
  #   games.select { |g| g.season == season }.each do |g|
  #     hash[g.away_team_id] += 1
  #     hash[g.home_team_id] += 1
  #   end
  #   hash
  # end

  # def win_percentage_per_season(season)
  #   wins = team_wins_per_season(season)
  #   totals = team_total_games_per_season(season)
  #
  #   totals.each do |season, total|
  #     totals[season] = (wins[season] / total.to_f * 100).round(2)
  #   end
  #   totals
  # end

  def win_percentage_per_season(season)
    by_team = games_in_season(season).group_by { |game| game.team_id }
    totals = {}
    by_team.each do |team, games|
      totals[team] = {games: 0, wins: 0}
      games.each do |game|
        totals[team][:games] += 1
        totals[team][:wins] += 1 if game.won
      end
    end
    totals.transform_values! { |info| info[:wins].to_f / info[:games]}
  end

  def winningest_coach(season)
    team_id = win_percentage_per_season(season).max_by {|k,v| v}[0]
    total_games_per_season(season).find { |team| team.team_id == team_id }
      .head_coach
  end

  def worst_coach(season)
    worst_team = win_percentage_per_season(season).min_by {|k,v| v}.first
    @game_teams.find { |team| team.team_id == worst_team }
      .head_coach
  end

  def team_total_shots_per_season(season)
    hash = Hash.new(0)
    total_games_per_season(season).each do |g|
      hash[g.team_id] += g.shots
    end
    hash
  end

  def team_total_goals_per_season(season)
    hash = Hash.new(0)
    total_games_per_season(season).each do |g|
      hash[g.team_id] += g.goals
    end
    hash
  end

  def shot_goal_ratio_per_team_per_season(season)
    shots = team_total_shots_per_season(season)
    goals = team_total_goals_per_season(season)

    goals.each do |season, goal|
      goals[season] = (shots[season] / goal.to_f).round(2)
    end
    goals
  end

  def most_accurate_team(season)
    team_id = shot_goal_ratio_per_team_per_season(season).max_by {|k,v| v}[0]
    teams.find { |team| team.team_id == team_id }.team_name
  end

  def least_accurate_team(season)
    team_id = shot_goal_ratio_per_team_per_season(season).min_by {|k,v| v}[0]
    teams.find { |team| team.team_id == team_id }.team_name
  end

  def most_hits(season)
    game_ids_in_season = @games.find_all{ |game| game.season == season }.map{ |game_id| game_id.game_id }
    game_teams_in_season = @game_teams.find_all{ |game_team| game_ids_in_season.include? game_team.game_id }
    hits_hash = Hash.new(0)
    game_teams_in_season.each{ |game_team| hits_hash[game_team.team_id] += game_team.hits }
    most_hits_team = hits_hash.max_by{ |key,value| value }.first
    get_team_name(most_hits_team)
  end

  def fewest_hits(season)
    game_ids_in_season = @games.find_all{ |game| game.season == season }.map{ |game_id| game_id.game_id }
    game_teams_in_season = @game_teams.find_all{ |game_team| game_ids_in_season.include? game_team.game_id }
    hits_hash = Hash.new(0)
    game_teams_in_season.each{ |game_team| hits_hash[game_team.team_id] += game_team.hits }
    fewest_hits_team = hits_hash.min_by{ |key,value| value }.first
    get_team_name(fewest_hits_team)
  end

  def power_play_goal_percentage(season)
    game_ids_in_season = @games.find_all{ |game| game.season == season }.map{ |game_id| game_id.game_id }
    game_teams_in_season = @game_teams.find_all{ |game_team| game_ids_in_season.include? game_team.game_id }
    total_goals = game_teams_in_season.map{ |game_team| game_team.goals }.sum
    total_pp_goals = game_teams_in_season.map{ |game_team| game_team.power_play_goals }.sum
    percentage = total_pp_goals / total_goals.to_f
    percentage.round(2)
  end
end
