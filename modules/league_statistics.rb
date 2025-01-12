module LeagueStatistics
  def team_total_goals
    team_goals = Hash.new(0)
    @game_teams.each { |team| team_goals[team.team_id] += team.goals }
    team_goals
  end

  def team_avg_goals_per_game
    goals_hash = team_total_goals
    goals_hash.each do |team, goals|
      goals_hash[team] = (goals.to_f / team_total_games_from_game_teams[team]).round(3)
    end
    @avg_goals_hash ||= goals_hash
  end

  def best_offense
    best_o_id = team_avg_goals_per_game.max_by {|team, goal_avg| goal_avg}.first
    get_team_name(best_o_id)
  end

  def worst_offense
    worst_o_id = team_avg_goals_per_game.min_by {|team, goal_avg| goal_avg}.first
    get_team_name(worst_o_id)
  end

  def team_home_goals_allowed
    home_goals_allowed = Hash.new(0)
    @games.each { |game| home_goals_allowed[game.home_team_id] += game.away_goals}
    home_goals_allowed
  end

  def team_away_goals_allowed
    away_goals_allowed = Hash.new(0)
    @games.each { |game| away_goals_allowed[game.away_team_id] += game.home_goals}
    away_goals_allowed
  end

  def team_avg_goals_allowed
    team_avg_goals = Hash.new
    team_home_goals_allowed.each do |team, goals|
      total_goals = goals + team_away_goals_allowed[team]
      team_avg_goals[team] = total_goals.to_f / team_total_games_from_games[team]
    end
    @team_avg_goals_hash ||= team_avg_goals
  end

  def best_defense
    best_d_id = team_avg_goals_allowed.min_by { |team, avg_goals| avg_goals }.first
    get_team_name(best_d_id)
  end

  def worst_defense
    worst_d_id = team_avg_goals_allowed.max_by { |team, avg_goals| avg_goals }.first
    get_team_name(worst_d_id)
  end

  def away_team_goals
    away_team_goals = Hash.new(0)
    @game_teams.each do |team|
        away_team_goals[team.team_id] += team.goals if team.home_or_away == "away"
    end
    away_team_goals
  end

  def home_team_goals
    home_team_goals = Hash.new(0)
    @game_teams.each do |team|
      home_team_goals[team.team_id] += team.goals if team.home_or_away == "home"
    end
    home_team_goals
  end

  def away_team_total_games
    each_total_games = Hash.new(0)
    @game_teams.each do |team|
      each_total_games[team.team_id] += 1 if team.home_or_away == "away"
    end
    each_total_games
  end

  def home_team_total_games
    each_total_games = Hash.new(0)
    @game_teams.each do |team|
      each_total_games[team.team_id] += 1 if team.home_or_away == "home"
    end
    each_total_games
  end

  def away_team_avg_goals_per_game
    goals_hash = away_team_goals
    goals_hash.each do |team, goals|
      goals_hash[team] = (goals.to_f / away_team_total_games[team]).round(3)
    end
    @away_avg_goals_hash ||= goals_hash
  end

  def home_team_avg_goals_per_game
    goals_hash = home_team_goals
    goals_hash.each do |team, goals|
      goals_hash[team] = (goals.to_f / home_team_total_games[team]).round(3)
    end
    @home_avg_goals_hash ||= goals_hash
  end

  def highest_scoring_visitor
    highest_away = away_team_avg_goals_per_game.max_by {|team, goal_avg| goal_avg}.first
    @teams.find { |team| team.team_id == highest_away}.team_name
  end

  def highest_scoring_home_team
    highest_home = home_team_avg_goals_per_game.max_by {|team, goal_avg| goal_avg}.first
    @teams.find { |team| team.team_id == highest_home}.team_name
  end

  def lowest_scoring_visitor
    lowest_away = away_team_avg_goals_per_game.min_by {|team, goal_avg| goal_avg}.first
    @teams.find { |team| team.team_id == lowest_away}.team_name
  end

  def lowest_scoring_home_team
    lowest_home = home_team_avg_goals_per_game.min_by {|team, goal_avg| goal_avg}.first
    @teams.find { |team| team.team_id == lowest_home}.team_name
  end

  def count_of_teams
    @teams.map {|team| team.team_id }.uniq.count
  end

  def wins_per_team
    team_wins = Hash.new(0)
    @game_teams.each do |team|
      if team.won
       team_wins[get_team_name(team.team_id)] += 1
      end
    end
    team_wins
  end

  def total_games_by_name
    by_id = team_total_games_from_game_teams
    by_name = Hash.new(0)
    by_id.each { |id, val| by_name[get_team_name(id)] += val }
    by_name
  end

  def winningest_team
    answer =  wins_per_team.map do |team, wins|
      [team, (wins.to_f / total_games_by_name[team] )]
    end.to_h
    answer.max_by{ |key, value| value }.first
  end

  def away_wins_by_id
    away_info = {}
    @games.each do |game|
      id = game.away_team_id
      away_info[id] = {a_games: 0, a_wins: 0} unless away_info.key? id
      away_info[id][:a_games] += 1
      away_info[id][:a_wins] += 1 if game.home_goals < game.away_goals
    end
    @away_wins ||= away_info
  end

  def home_wins_by_id
    home_info = {}
    @games.each do |game|
      id = game.home_team_id
      home_info[id] = {h_games: 0, h_wins: 0} unless home_info.key? id
      home_info[id][:h_games] += 1
      home_info[id][:h_wins] += 1 if game.home_goals > game.away_goals
    end
    @home_wins ||= home_info
  end

  def home_away_win_pct
    home_wins = home_wins_by_id
    away_wins = away_wins_by_id
    percents = {}
    home_wins.each do |team, info|
      percents[team] = {home_pct: 0, away_pct: 0}
      percents[team][:home_pct] = home_wins[team][:h_wins] / home_wins[team][:h_games].to_f
      percents[team][:away_pct] = away_wins[team][:a_wins] / away_wins[team][:a_games].to_f
    end
    @home_away_percents ||= percents
  end

  def best_fans
    best = home_away_win_pct
      .transform_values { |info| info[:home_pct] - info[:away_pct] }
      .max_by {|k,v| v}
      .first
    get_team_name(best)
  end

  def worst_fans
    home_away_win_pct.find_all { |team, info| info[:away_pct] > info[:home_pct] }
      .map(&:first)
      .map { |id| get_team_name(id) }
  end
end
