module CountsAndAverages

  def count_of_games_by_season
    season_games = Hash.new(0)
    @games.each { |game| season_games[game.season] += 1}
    season_games
  end

  def average_goals_per_game
    total = @games.sum {|game| game.home_goals + game.away_goals }
    (total / @games.length.to_f).round(2)
  end

  def average_goals_by_season
    num_games = count_of_games_by_season

    tot_goals = Hash.new(0)
    @games.each do |game|
      tot_goals[game.season] += (game.home_goals + game.away_goals)
    end

    tot_goals.each do |season, goals|
      tot_goals[season] = goals.to_f / num_games[season]
    end

    tot_goals
  end
end
