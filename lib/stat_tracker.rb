require 'csv'
require './lib/game'
require './lib/team_info'

class StatTracker
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

    StatTracker.new(games: games, team_info: team_info)
  end
end
