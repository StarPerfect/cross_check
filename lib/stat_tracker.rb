require 'csv'

class StatTracker

  def self.from_csv(files)
    data = {}
    files.each { |key, val| data[key] = CSV.read(val) }
    data
  end
end

game_path = './test/dummy_data/dummy_game.csv'
team_path = './test/dummy_data/dummy_team_info.csv'
game_teams_path = './test/dummy_data/dummy_game_teams_stats.csv'

files = {
  game: game_path,
  team: team_path,
  game_team: game_teams_path
}

s = StatTracker.from_csv(files)

require 'pry';binding.pry
