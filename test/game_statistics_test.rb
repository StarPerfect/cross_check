require './test/test_helper'
require 'Minitest/autorun'
require 'Minitest/pride'
require './lib/stat_tracker'
require './modules/game_statistics'

class GameStatisticsTest < Minitest::Test
  def setup
    files = {
      games:      './test/dummy_data/dummy_game.csv',
      team_info:      './test/dummy_data/dummy_team_info.csv',
      game_teams: './test/dummy_data/dummy_game_teams_stats.csv'
    }
    @stat_tracker = StatTracker.from_csv(files)
  end

  def test_highest_total_score
    assert_equal 9, @stat_tracker.highest_total_score
  end

  def test_lowest_total_score
    assert_equal 3, @stat_tracker.lowest_total_score
  end

  def test_biggest_blowout
    assert_equal 6, @stat_tracker.biggest_blowout
  end

  def test_percentage_home_wins
    assert_equal 58.33, @stat_tracker.percentage_home_wins
  end

  def test_percentage_visitor_wins
    assert_equal 41.67, @stat_tracker.percentage_visitor_wins
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
