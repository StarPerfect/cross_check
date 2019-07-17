require './test/test_helper'
require './lib/stat_tracker'
require 'minitest/autorun'
require 'minitest/pride'

class CountsAndAveragesTest < Minitest::Test

  def setup
    files = {
      games:      './test/dummy_data/dummy_game.csv',
      team_info:      './test/dummy_data/dummy_team_info.csv',
      game_teams: './test/dummy_data/dummy_game_teams_stats.csv'
    }
    @stat_tracker = StatTracker.from_csv(files)
  end

  def test_count_of_games_by_season
    expected = {
      '20122013' => 4,
      '20142015' => 4,
      '20162017' => 4
    }
    assert_equal expected, @stat_tracker.count_of_games_by_season
  end

  def test_average_goals_per_game
    assert_equal 5.25, @stat_tracker.average_goals_per_game
  end

  def test_average_goals_by_season
    expected = {
      '20122013' => 5.5,
      '20142015' => 4.5,
      '20162017' => 5.75
    }
    assert_equal expected, @stat_tracker.average_goals_by_season
  end
end
