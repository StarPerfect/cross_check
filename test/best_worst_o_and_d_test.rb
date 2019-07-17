require './test/test_helper'
require 'Minitest/autorun'
require 'Minitest/pride'
require './lib/stat_tracker'
require './modules/best_worst_o_and_d'

class BestWorstOAndDTest < Minitest::Test
  include BestWorstOAndD

  def setup
    files = {
      games:      './test/dummy_data/dummy_game.csv',
      team_info:  './test/dummy_data/dummy_team_info.csv',
      game_teams: './test/dummy_data/dummy_game_teams_stats.csv'
    }
    @stat_tracker = StatTracker.from_csv(files)
  end

  def test_team_total_games
    expected = {
      "3" => 5,
      "5" => 3,
      "6" => 8
    }
    assert_equal expected, @stat_tracker.team_total_games
  end

  def test_team_total_goals
    expected = {
      "3" => 10,
      "6" => 27,
      "5" => 2
    }
    assert_equal expected, @stat_tracker.team_total_goals
  end

  def test_team_avg_goals_per_game
    expected = {
      "3" => 2.0,
      "6" => 3.375,
      "5" => 0.667
    }
    assert_equal expected, @stat_tracker.team_avg_goals_per_game
  end

  def test_best_offense
    assert_equal "Bruins", @stat_tracker.best_offense
  end

  def test_worst_offense
    assert_equal "Penguins", @stat_tracker.worst_offense
  end

  # Name of the team with the lowest average number of goals
  # allowed per game across all seasons.
  def test_best_defense

  end

  # Name of the team with the highest average number of goals
  # allowed per game across all seasons.
  def test_worst_defense

  end
end
