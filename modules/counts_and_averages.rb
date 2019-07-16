module CountsAndAverages

  def count_of_games_by_season
    season_games = Hash.new(0)
    @games.each { |row| season_games[row.season] += 1}
    season_games
  end

  def average_goals_per_game
    total = @games.sum {|game| game.home_goals + game.away_goals }
    (total / @games.length.to_f).round(2)
  end


end
