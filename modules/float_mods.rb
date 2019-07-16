module FloatMods
  def percentage_home_wins
    home_wins = 0
    @games.map do |game|
      if game.outcome.include?('home')
        home_wins += 1
      end
    end
    ((home_wins.to_f / @games.count.to_f) * 100).round(2)
  end
end
