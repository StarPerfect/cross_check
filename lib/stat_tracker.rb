require 'csv'
require_relative '../lib/game'
require_relative '../lib/team_info'
require_relative '../lib/game_teams_stats'
require_relative '../modules/game_statistics'
require_relative '../modules/league_statistics'
require_relative '../modules/team_statistics'
require_relative '../modules/stat_helpers'

class StatTracker
  include GameStatistics
  include LeagueStatistics
  include TeamStatistics
  include StatHelpers

  attr_reader :games, :game_teams, :teams

  def initialize(args)
    @games = args[:games]
    @game_teams = args[:game_teams]
    @teams = args[:teams]
  end

  def self.from_csv(locations)
    data = {}
    locations.each do |key, csv|
      this_data = CSV.read(locations[key],
        headers: true,
        header_converters: :symbol)
      if key == :games
        data[key] = this_data.map { |row| Game.new(row) }
      elsif key == :teams
        data[key] = this_data.map { |row| TeamInfo.new(row) }
      elsif key == :game_teams
        data[key] = this_data.map { |row| GameTeamsStats.new(row) }
      end
    end

    StatTracker.new(data)
  end
end
