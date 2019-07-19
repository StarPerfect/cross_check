require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require './modules/nancy_it5'
require 'pry'

class NancyIt5Test < Minitest::Test
  def setup
    files = {
      games: './test/dummy_data/dummy_game.csv',
      teams: './test/dummy_data/dummy_team_info.csv',
      game_teams: './test/dummy_data/dummy_game_teams_stats.csv'
    }

    @stat_tracker= StatTracker.from_csv(files)
  end

  def test_winningest_coach
    assert_equal "Claude Julien", @stat_tracker.winningest_coach("20122013")
  end

  def test_worst_coach
    assert_equal "John Tortorella", @stat_tracker.worst_coach("20122013")
  end

  def test_most_accurate_team
    assert_equal "Rangers", @stat_tracker.most_accurate_team("20122013")
  end

  def test_least_accurate_team
    assert_equal "Bruins", @stat_tracker.least_accurate_team("20122013")
  end
end
