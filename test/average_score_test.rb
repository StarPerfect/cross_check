require './test/test_helper'
require 'Minitest/autorun'
require 'Minitest/pride'
require './lib/stat_tracker'
require './modules/average_score'
require 'pry'

class AverageScoreModuleTest < Minitest::Test

  def setup
    game_path = './test/dummy_data/dummy_game.csv'
    team_path = './test/dummy_data/dummy_team_info.csv'
    game_teams_path = './test/dummy_data/dummy_game_teams_stats.csv'

    locations = {
      games: game_path,
      team_info: team_path,
      game_teams: game_teams_path
    }

    @stat_1 = StatTracker.from_csv(locations)
  end

  def test_highest_scoring_visitor
    assert_equal "Bruins", @stat_1.highest_scoring_visitor
  end

  def test_highest_scoring_home_team
    assert_equal "Bruins", @stat_1.highest_scoring_home_team
  end

  def test_lowest_scoring_visitor
    assert_equal "Penguins", @stat_1.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    assert_equal "Penguins", @stat_1.lowest_scoring_home_team
  end
end
