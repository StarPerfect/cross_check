require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require './modules/nancy_it4'

class It4NancyTest < Minitest::Test
  def setup
    files = {
      games: './test/dummy_data/dummy_game_3.csv',
      teams: './test/dummy_data/dummy_team_info.csv',
      game_teams: './test/dummy_data/dummy_game_teams_stats.csv'
    }

    @stat_tracker= StatTracker.from_csv(files)
  end

  def test_team_info
    expected = {
      "team_id" => "6",
      "franchise_id" => "6",
      "short_name" => "Boston",
      "team_name" => "Bruins",
      "abbreviation" => "BOS",
      "link" => "/api/v1/teams/6"
    }
    assert_equal expected, @stat_tracker.team_info("6")
  end

  def test_best_season
    assert_equal "20132014", @stat_tracker.best_season("6")
  end

  def test_worst_season
    assert_equal "20142015", @stat_tracker.worst_season("6")
  end

end
