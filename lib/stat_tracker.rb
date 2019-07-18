require 'csv'
require_relative '../lib/game'
require_relative '../lib/team_info'
require_relative '../lib/game_teams_stats'
require_relative '../modules/game_statistics'
require_relative '../modules/best_worst_o_and_d'
require_relative '../modules/fenton_it4'
require_relative '../modules/corina'

class StatTracker
  include GameStatistics
  include BestWorstOAndD
  include FentonIt4
  include Corina

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
