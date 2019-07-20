module FentonIt5
  def win_percent_by_type(season)
    this_season = @games.select { |game| game.season == season }
    regular = {}
    playoffs = {}
    this_season.each do |game|
      if game.type == 'R'
        regular[game.away_team_id] = {total: 0, wins: 0} unless regular.key? game.away_team_id
        regular[game.home_team_id] = {total: 0, wins: 0} unless regular.key? game.home_team_id
        regular[game.away_team_id][:total] += 1
        regular[game.home_team_id][:total] += 1
        regular[game.away_team_id][:wins] += 1 if game.away_goals > game.home_goals
        regular[game.home_team_id][:wins] += 1 if game.home_goals > game.away_goals
      else
        playoffs[game.away_team_id] = {total: 0, wins: 0} unless playoffs.key? game.away_team_id
        playoffs[game.home_team_id] = {total: 0, wins: 0} unless playoffs.key? game.home_team_id
        playoffs[game.away_team_id][:total] += 1
        playoffs[game.home_team_id][:total] += 1
        playoffs[game.away_team_id][:wins] += 1 if game.away_goals > game.home_goals
        playoffs[game.home_team_id][:wins] += 1 if game.home_goals > game.away_goals
      end
    end
    {regular_season: regular, playoff_games: playoffs}
  end

  def postseason_change(season)
    totals = win_percent_by_type(season)
    percents = {}
    totals.each do |season_type, teams|
      percents[season_type] = {}
      teams.each do |team, values|
        percents[season_type][team] = values[:wins] / values[:total].to_f
      end
    end
    reg = percents[:regular_season]
    post = percents[:playoff_games]
    post.each do |team, percent|
      # require 'pry';binding.pry #should work with real data
      post[team] = percent - reg[team]
    end
    post
  end

  def biggest_bust(season)
    get_team_name( postseason_change(season).min_by { |team, diff| diff }.first )
  end

  def biggest_surprise(season)
    get_team_name( postseason_change(season).max_by { |team, diff| diff }.first )
  end
end
