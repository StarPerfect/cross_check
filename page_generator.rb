require './lib/stat_tracker'
require './modules/game_statistics'
require './modules/league_statistics'
require './modules/team_statistics'
require './modules/season_statistics'
require 'erb'

game_path = './data/game.csv'
team_path = './data/team_info.csv'
game_teams_path = './data/game_teams_stats.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

@stat_tracker = StatTracker.from_csv(locations)

template = File.read('./site/index.html.erb')
game = File.read('./site/stats/game.html.erb')
league = File.read('./site/stats/league.html.erb')
team = File.read('./site/stats/team.html.erb')
season = File.read('./site/stats/season.html.erb')
season_sum = File.read('./site/stats/season_sum.html.erb')

File.write('./site/index.html', ERB.new(template).result(binding))
File.write('./site/stats/game.html', ERB.new(game).result(binding))
File.write('./site/stats/league.html', ERB.new(league).result(binding))
File.write('./site/stats/team.html', ERB.new(team).result(binding))
File.write('./site/stats/season.html', ERB.new(season).result(binding))
File.write('./site/stats/season_sum.html', ERB.new(season_sum).result(binding))
