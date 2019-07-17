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

  # Name of the team with the highest average number of goals scored
  # per game across all seasons.
  def test_best_offense
    assert_equal
  end

  # Name of the team with the lowest average number of goals scored
  # per game across all seasons.
  def test_worst_offense

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
