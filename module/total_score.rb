require 'csv'

module TotalScore

    def total_score
      game_table = CSV.table('./dummy_data/dummy_game.csv')
      total_scores_arr = game_table[:away_goals].zip(game_table[:home_goals]).map(&:sum)
    end

    def highest_total_score
      total_score.max
    end

    def lowest_total_score
      total_score.min
    end

    def biggest_blowout
      highest_total_score - lowest_total_score
    end

end
