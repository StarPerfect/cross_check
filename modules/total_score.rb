require 'csv'

module TotalScore

    def highest_total_score
      games.map { |game| game.away_goals + game.home_goals }
        .max
    end

    def lowest_total_score
      games.map { |game| game.away_goals + game.home_goals }
        .min
    end

    def biggest_blowout
      highest_total_score - lowest_total_score
    end

end
