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
      post[team] = percent - reg[team]
    end
  end

  def biggest_bust(season)
    get_team_name( postseason_change(season).min_by { |team, diff| diff }.first )
  end

  def biggest_surprise(season)
    get_team_name( postseason_change(season).max_by { |team, diff| diff }.first )
  end

  def games_in_season(season)
    game_ids = []
    @games.each { |g| game_ids << g.game_id if g.season == season }
    @game_teams.select { |g| game_ids.include? g.game_id }
  end

  def coach_win_percentage_per_season(season)
    by_coach = games_in_season(season).group_by { |game| game.head_coach }
    totals = {}
    by_coach.each do |coach, games|
      totals[coach] = {games: 0, wins: 0}
      games.each do |game|
        totals[coach][:games] += 1
        totals[coach][:wins] += 1 if game.won
      end
    end
    totals.transform_values { |info| info[:wins].to_f / info[:games] }
  end

  def winningest_coach(season)
    coach_win_percentage_per_season(season).max_by {|k,v| v}.first
  end

  def worst_coach(season)
    coach_win_percentage_per_season(season).min_by {|k,v| v}.first
  end

  def shots_and_goals_per_season(season)
    hash = {}
    games_in_season(season).each do |game|
      id = game.team_id
      hash[id] = {shots: 0, goals: 0} unless hash.key? id
      hash[id][:shots] += game.shots
      hash[id][:goals] += game.goals
    end
    hash
  end

  def shot_goal_ratio_per_team(season)
    shots_and_goals_per_season(season).transform_values do |info|
      info[:goals].to_f / info[:shots]
    end
  end

  def most_accurate_team(season)
    team_id = shot_goal_ratio_per_team(season).max_by {|k,v| v}[0]
    teams.find { |team| team.team_id == team_id }.team_name
  end

  def least_accurate_team(season)
    team_id = shot_goal_ratio_per_team(season).min_by {|k,v| v}[0]
    teams.find { |team| team.team_id == team_id }.team_name
  end

  def team_hits(season)
    by_team = games_in_season(season)
      .group_by { |game| game.team_id }
    by_team.transform_values! do |games|
      games.map {|game| game.hits}.sum
    end
  end

  def most_hits(season)
    most_hits_team = team_hits(season).max_by { |key,value| value }.first
    get_team_name(most_hits_team)
  end

  def fewest_hits(season)
    fewest_hits_team = team_hits(season).min_by{ |key,value| value }.first
    get_team_name(fewest_hits_team)
  end

  def power_play_goal_percentage(season)
    season_games = games_in_season(season)
    total_goals = season_games.map{ |game_team| game_team.goals }.sum
    total_pp_goals = season_games.map{ |game_team| game_team.power_play_goals }.sum
    ( total_pp_goals / total_goals.to_f ).round(2)
  end
end
