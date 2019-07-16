require 'csv'
require './lib/game'
require './lib/team_info'
require './lib/game_teams_stats'
require './modules/total_score'


class StatTracker

  include TotalScore

  attr_reader :games, :game_teams, :team_info

  def initialize(args)
    @games = args[:games]
    @game_teams = args[:game_teams]
    @team_info = args[:info]
  end

  def self.from_csv
    games_data = CSV.read('./test/dummy_data/dummy_game.csv',
      headers: true,
      header_converters: :symbol)
    games = games_data.map {|row| Game.new(row)}

    teams_data = CSV.read('./test/dummy_data/dummy_team_info.csv',
      headers: true,
      header_converters: :symbol)
    team_info = teams_data.map {|row| TeamInfo.new(row)}

    game_teams_stats_data = CSV.read('./test/dummy_data/dummy_game_teams_stats.csv',
      headers: true,
      header_converters: :symbol)
    game_teams_stats = game_teams_stats_data.map {|row| GameTeamsStats.new(row)}


    StatTracker.new(games: games, team_info: team_info, game_teams: game_teams_stats)
  end
end
