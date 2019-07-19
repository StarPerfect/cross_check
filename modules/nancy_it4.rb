module NancyIt4

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

  def win_percentage(id)
    wins_arr = total_wins_per_team_per_season(id).map {|k,v| v}
    total_arr = total_games_per_team_per_season(id).map {|k,v| v}
    wins_arr.zip(total_arr).map {|arr| (arr[0]/arr[1].to_f * 100).round(2) }
  end

  def win_percentage_per_season(id)
    seasons = total_games_per_team_per_season(id).keys
    percentages = win_percentage(id)
    Hash[seasons.zip(percentages)]
  end

  def best_season(id)
    win_percentage_per_season(id).max_by {|k,v| v}[0]
  end

  def worst_season(id)
    win_percentage_per_season(id).min_by {|k,v| v}[0]
  end
end
