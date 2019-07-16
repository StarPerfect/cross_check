module TotalScore

    def total_score
      total_score = []
      CSV.foreach(filepath, :headers => true, :col_sep => ',') do |row|
        total_score << row[6].to_i + row[7].to_i
      end

      total_score
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
