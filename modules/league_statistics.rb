module LeagueStatistics
  def team_total_games
    each_total_games = Hash.new(0)
    @game_teams.each { |game_team| each_total_games[game_team.team_id] += 1}
    each_total_games
  end

  def team_total_games_2
    each_total_games = Hash.new(0)
    @games.each do |game|
      each_total_games[game.home_team_id] += 1
      each_total_games[game.away_team_id] += 1
    end
    each_total_games
  end

  def team_total_goals
    team_goals = Hash.new(0)
    @game_teams.each { |team| team_goals[team.team_id] += team.goals }
    team_goals
  end

  def team_avg_goals_per_game
    goals_hash = team_total_goals
    goals_hash.each do |team, goals|
      goals_hash[team] = (goals.to_f / team_total_games[team]).round(3)
    end
    goals_hash
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
      team_avg_goals[team] = total_goals.to_f / team_total_games_2[team]
    end
    team_avg_goals
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
    goals_hash
  end

  def home_team_avg_goals_per_game
    goals_hash = home_team_goals
    goals_hash.each do |team, goals|
      goals_hash[team] = (goals.to_f / home_team_total_games[team]).round(3)
    end
    goals_hash
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
    @teams.count
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
    @teams.find{ |team| team.team_id == answer[0] }.team_name
  end

  def home_wins_per_team
    home_wins = Hash.new(0)
    @game_teams.each do |team|
      if team.won && team.home_or_away == 'home'
       home_wins[team.team_id] += 1
      end
    end
    home_wins
  end

  def away_wins_per_team
    away_wins = Hash.new(0)
    @game_teams.each do |team|
      if team.won && team.home_or_away == 'away'
       away_wins[team.team_id] += 1
      end
    end
    away_wins
  end

  def best_fans
    home_wins_per_team.each do |team, wins|
      home_wins_per_team[team] = (wins - away_wins_per_team[team])
    end
    answer = home_wins_per_team.max_by{ |key, value| value }
    @teams.find{ |team| team.team_id == answer[0] }.team_name
  end

  def worst_fans
    crap_fans = @teams.find_all{ |team| home_wins_per_team[team.team_id] < away_wins_per_team[team.team_id] }
    crap_fans.map{|team| get_team_name(team.team_id )}
  end
end