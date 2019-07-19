module SeasonSum
  def team_wins_per_season(team_id)
    hash = Hash.new(0)
    @games.each do |game|
      if game.away_team_id == team_id && game.away_goals > game.home_goals
        hash[:team_wins] += 1
      elsif game.home_team_id == team_id && game.away_goals < game.home_goals
        hash[:team_wins] += 1
      end
    end
    hash
  end

  def total_games_per_team(id)
    @games.select { |game| game.away_team_id == id || game.home_team_id == id }
  end

  def total_games_per_team_per_season(id)
    hash = Hash.new(0)
    total_games_per_team(id).each do |game|
      hash[game.season] += 1
    end
    hash
  end

  def total_wins_per_team_per_season(id)
    hash = Hash.new(0)
    total_games_per_team(id).each do |game|
      if game.away_team_id == id && (game.away_goals > game.home_goals)
        hash[game.season] += 1
      elsif game.home_team_id == id && (game.home_goals > game.away_goals)
        hash[game.season] += 1
      end
    end
    hash
  end

  def win_percentage_per_season(id)
    wins = total_wins_per_team_per_season(id)
    totals = total_games_per_team_per_season(id)
    totals.each do |season, total|
      totals[season] = (wins[season] / total.to_f * 100).round(2)
    end
  end


  def seasonal_summary(team_id)
    macro_hash = Hash.new
    micro_hash= Hash.new
    keys = [:win_percentage, :total_goals_scored, :total_goals_against, :average_goals_scored, :average_goals_against]
    info = Hash[keys.each_with_object(0).to_a]

    games_per_season_per_team = games.select { |game| game.away_team_id == team_id || game.home_team_id == team_id }
      .group_by { |game| game.season }
      .map do |k, v|
        v.map do |game|
          micro_hash[:postseason] = info unless micro_hash.key? "P"
          micro_hash[:regular_season] = info unless micro_hash.key? "R"
          macro_hash[k] = micro_hash
        end
      end
    macro_hash
  end


  # response_hash = Hash.new {|h, k| h[k] = Hash.new(&h.default_proc)}
  # keys = [:win_percentage, :total_goals_scored, :total_goals_against, :average_goals_scored, :average_goals_against]
  # info = Hash[keys.each_with_object(0).to_a]
  #
  # games.each do |game|
  #   response_hash[game.season][game.type] = info unless response_hash[game.season].key? game.type
  # end
  # response_hash
end
