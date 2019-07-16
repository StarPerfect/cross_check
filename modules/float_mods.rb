module FloatMods
  def percentage_home_wins
    home_wins = 0
    @game_data.map do |game|
      if game.include?('home')
        home_wins += 1
      end
    end
      require "pry"; binding.pry
    (home_wins / @game_data[:outcome].count).to_f * 100
  end
end
