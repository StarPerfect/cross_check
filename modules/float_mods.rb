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

  def percentage_visitor_wins
    visitor_wins = 0
    @games.map do |game|
      if game.outcome.include?('away')
        visitor_wins += 1
      end
    end
    ((visitor_wins.to_f / @games.count.to_f) * 100).round(2)

  end
end
