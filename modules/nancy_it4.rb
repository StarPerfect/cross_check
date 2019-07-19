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
end
