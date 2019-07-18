module FentonIt4
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

  # def losses_to(id)
  #   losses = {}
  #   wins = wins_against(id)
  #   times_played(id).each { |key, val| losses[key] = val - wins[key] }
  #   losses
  # end

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
end
