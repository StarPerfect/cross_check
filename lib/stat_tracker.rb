require 'csv'
require './lib/game'
require './lib/team_info'
require './lib/game_teams_stats'
require './modules/game_statistics'
require './modules/it4_nancy'

class StatTracker
  include GameStatistics
  include It4Nancy

  attr_reader :games, :game_teams, :team_info

  def initialize(args)
    @games = args[:games]
    @game_teams = args[:game_teams]
    @team_info = args[:team_info]
  end

  def self.from_csv(locations)
    data = {}
    locations.each do |key, csv|
      this_data = CSV.read(locations[key],
        headers: true,
        header_converters: :symbol)
      if key == :games
        data[key] = this_data.map { |row| Game.new(row) }
      elsif key == :team_info
        data[key] = this_data.map { |row| TeamInfo.new(row) }
      elsif key == :game_teams
        data[key] = this_data.map { |row| GameTeamsStats.new(row) }
      end
    end

    StatTracker.new(data)
  end
end
