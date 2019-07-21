module SeasonSum

  def seasonal_summary(team_id)
    hash = Hash.new { |hash, key| hash[key] = {} }

    games.select {|game| game.away_team_id == team_id || game.home_team_id == team_id}
      .group_by {|game_obj| game_obj.season}
      .each do |season, games|
        p_wins = 0
        p_total_goals_scored = 0
        p_total_goals_against = 0
        p_game_totals = 0

        r_wins = 0
        r_total_goals_scored = 0
        r_total_goals_against = 0
        r_game_totals = 0

        games.each do |game|
          if game.type == "P"
            if game.away_team_id == team_id
              p_total_goals_scored += game.away_goals
              p_total_goals_against += game.home_goals
              p_game_totals += 1
              p_wins += 1 if game.away_goals > game.home_goals
            elsif game.home_team_id == team_id
              p_total_goals_scored += game.home_goals
              p_total_goals_against += game.away_goals
              p_game_totals += 1
              p_wins += 1 if game.home_goals > game.away_goals
            end

          elsif game.type == "R"
              if game.away_team_id == team_id
                r_total_goals_scored += game.away_goals
                r_total_goals_against += game.home_goals
                r_game_totals += 1
                r_wins += 1 if game.away_goals > game.home_goals
              elsif game.home_team_id == team_id
                r_total_goals_scored += game.home_goals
                r_total_goals_against += game.away_goals
                r_game_totals += 1
                r_wins += 1 if game.home_goals > game.away_goals
              end
          end
        end

        post_info = {
          :win_percentage => p_game_totals == 0 ? 0 : (p_wins / p_game_totals.to_f).round(2),
          :total_goals_scored => p_total_goals_scored,
          :total_goals_against => p_total_goals_against,
          :average_goals_scored => p_game_totals == 0 ? 0 : (p_total_goals_scored / p_game_totals.to_f).round(2),
          :average_goals_against => p_game_totals == 0 ? 0 : (p_total_goals_against / p_game_totals.to_f).round(2)
        }

        reg_info = {
          :win_percentage => r_game_totals == 0 ? 0 : (r_wins / r_game_totals.to_f).round(2),
          :total_goals_scored => r_total_goals_scored,
          :total_goals_against => r_total_goals_against,
          :average_goals_scored => r_game_totals == 0 ? 0 : (r_total_goals_scored / r_game_totals.to_f).round(2),
          :average_goals_against => r_game_totals == 0 ? 0 : (r_total_goals_against / r_game_totals.to_f).round(2)
        }


        hash[season][:postseason] = post_info
        hash[season][:regular_season] = reg_info
      end
    hash
  end

end
