module GameStatistics
  def highest_total_score
    @games.map { |game| game.away_goals + game.home_goals }.max
  end

  def lowest_total_score
    @games.map { |game| game.away_goals + game.home_goals }.min
  end

  def biggest_blowout
    biggest = 0
    @games.each do |game|
      diff = (game.away_goals - game.home_goals).abs
      biggest = diff if diff > biggest
    end
    biggest 
  end

  def percentage_home_wins
    home_wins = 0
    @games.map do |game|
      if game.outcome.include?('home')
        home_wins += 1
      end
    end
    (home_wins.to_f / @games.count.to_f).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = 0
    @games.map do |game|
      if game.outcome.include?('away')
        visitor_wins += 1
      end
    end
    (visitor_wins.to_f / @games.count.to_f).round(2)
  end

  def count_of_games_by_season
    season_games = Hash.new(0)
    @games.each { |game| season_games[game.season] += 1 }
    season_games
  end

  def average_goals_per_game
    total = @games.sum { |game| game.home_goals + game.away_goals }
    ( total / @games.length.to_f ).round(2)
  end

  def average_goals_by_season
    num_games = count_of_games_by_season

    tot_goals = Hash.new(0)
    @games.each do |game|
      tot_goals[game.season] += ( game.home_goals + game.away_goals )
    end

    tot_goals.each do |season, goals|
      tot_goals[season] = ( goals.to_f / num_games[season] ).round(2)
    end

    tot_goals
  end
end
