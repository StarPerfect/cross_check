module TeamStatistics
  def team_info(id)
    hash = Hash.new(0)
    team = @teams.select { |team| team.team_id == id }[0]
    team.instance_variables
      .each do |var|
        hash[var.to_s.delete("@")] = team.instance_variable_get(var)
      end
    hash
  end

  def total_games_per_team(id)
    @games.select { |game| game.away_team_id == id || game.home_team_id == id }
  end

  def total_games_per_team_per_season(id)
    hash = Hash.new(0)
    total_games_per_team(id).each do |game|
      hash[game.season] += 1
    end
    hash
  end

  def total_wins_per_team_per_season(id)
    hash = Hash.new(0)
    total_games_per_team(id).each do |game|
      if game.away_team_id == id && (game.away_goals > game.home_goals)
        hash[game.season] += 1
      elsif game.home_team_id == id && (game.home_goals > game.away_goals)
        hash[game.season] += 1
      end
    end
    hash
  end

  def win_percentage_per_season(id)
    wins = total_wins_per_team_per_season(id)
    totals = total_games_per_team_per_season(id)
    totals.each do |season, total|
      totals[season] = (wins[season] / total.to_f * 100).round(2)
    end
  end

  def best_season(id)
    win_percentage_per_season(id).max_by {|k,v| v}[0]
  end

  def worst_season(id)
    win_percentage_per_season(id).min_by {|k,v| v}[0]
  end

  def average_win_percentage(team)
    id = get_team_id_from_name(team)
    (wins_per_team[id].to_f / team_total_games_from_games[id] * 100).round(2)
  end

  def most_goals_scored(team)
    id = get_team_id_from_name(team)
    max_score = 0
    @game_teams.each do |team|
      if team.team_id == id && team.goals > max_score
        max_score = team.goals
      end
    end
    max_score
  end

  def fewest_goals_scored(team)
    id = get_team_id_from_name(team)
    min_score = 100
    @game_teams.each do |team|
      if team.team_id == id && team.goals < min_score
        min_score = team.goals
      end
    end
    min_score
  end

  def times_played(id)
    times = Hash.new(0)
    @games.each do |game|
      times[game.home_team_id] += 1 if id == game.away_team_id
      times[game.away_team_id] += 1 if id == game.home_team_id
    end
    times
  end

  def wins_against(id)
    wins = Hash.new(0)
    @games.each do |game|
      if game.home_team_id == id && game.home_goals > game.away_goals
        wins[game.away_team_id] += 1
      elsif game.away_team_id == id && game.away_goals > game.home_goals
        wins[game.home_team_id] += 1
      end
    end
    wins
  end

  def win_percent_against(id)
    percents = {}
    times_pl = times_played(id)
    wins = wins_against(id)
    times_pl.each { |key, val| percents[key] = wins[key] / val.to_f }
    percents
  end

  def favorite_opponent(id)
    fav = win_percent_against(id).max_by { |key, val| val}.first
    get_team_name(fav)
  end

  def rival(id)
    riv = win_percent_against(id).min_by { |key, val| val}.first
    get_team_name(riv)
  end

  def biggest_team_blowout(id)
    max_blowout = 0
    @games.each do |game|
      if game.home_team_id == id && game.home_goals > game.away_goals
        diff = game.home_goals - game.away_goals
        max_blowout =  diff if diff > max_blowout
      elsif game.away_team_id == id && game.away_goals > game.home_goals
        diff = game.away_goals - game.home_goals
        max_blowout =  diff if diff > max_blowout
      end
    end
    max_blowout
  end

  def worst_loss(id)
    worst = 0
    @games.each do |game|
      if game.home_team_id == id && game.home_goals < game.away_goals
        diff = game.away_goals - game.home_goals
        worst = diff if diff > worst
      elsif game.away_team_id == id && game.away_goals < game.home_goals
        diff = game.home_goals - game.away_goals
        worst = diff if diff > worst
      end
    end
    worst
  end

  def head_to_head(id)
    name_percents = {}
    win_percent_against(id).each do |team, pct|
      name_percents[get_team_name(team)] = pct
    end
    name_percents
  end
end
