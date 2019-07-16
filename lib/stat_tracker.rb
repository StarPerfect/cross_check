require 'csv'
require './lib/game'
require './lib/team_info'
require './lib/game_teams_stats'


class StatTracker
  attr_reader :games, :game_teams, :team_info

  def initialize(args)
    @games = args[:games]
    @game_teams = args[:game_teams]
    @team_info = args[:info]
  end

  def self.from_csv(locations)
    games_data = CSV.read(locations[:games],
      headers: true,
      header_converters: :symbol)
    games = games_data.map {|row| Game.new(row)}

    teams_data = CSV.read(locations[:teams],
      headers: true,
      header_converters: :symbol)
    team_info = teams_data.map {|row| TeamInfo.new(row)}

    game_teams_stats_data = CSV.read(locations[:game_teams],
      headers: true,
      header_converters: :symbol)
    game_teams_stats = game_teams_stats_data.map {|row| GameTeamsStats.new(row)}


    StatTracker.new(games: games, team_info: team_info, game_teams: game_teams_stats)
  end
end
