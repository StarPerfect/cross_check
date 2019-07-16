require './test/test_helper'
require 'Minitest/autorun'
require 'Minitest/pride'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test
  # def setup
  #   @game_path = './test/dummy_data/dummy_game.csv'
  #   @team_path = './test/dummy_data/dummy_team_info.csv'
  #   @game_teams_path = './test/dummy_data/dummy_game_teams_stats.csv'
  #
  #   @locations = {
  #     games: @game_path,
  #     teams: @team_path,
  #     game_teams: @game_teams_path
  #   }
  #   @stat_tracker = StatTracker.new
  #   @data = StatTracker.from_csv(@locations)
  # end
  #
  # def test_stat_tracker_exists
  #   assert_instance_of StatTracker, @stat_tracker
  # end
end
