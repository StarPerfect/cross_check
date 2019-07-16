require 'csv'

class StatTracker
  def self.from_csv(files)
    data = {}
    files.each { |key, val| data[key] = CSV.table(val) }
    data
  end
end

game_path = './test/dummy_data/dummy_game.csv'
team_path = './test/dummy_data/dummy_team_info.csv'
game_teams_path = './test/dummy_data/dummy_game_teams_stats.csv'

files = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stats_1 = StatTracker.from_csv(files)
stats_2 = StatTracker.from_csv_2(files)

require 'pry';binding.pry
