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

  def test_total_games_per_team
    assert_equal 23, @stat_tracker.total_games_per_team("6").length
  end

  def test_total_games_per_team_per_season
    expected = {
      "20122013"=>10,
      "20172018"=>7,
      "20132014"=>2,
      "20142015"=>4
    }

    assert_equal expected, @stat_tracker.total_games_per_team_per_season("6")
  end

  def test_total_wins_per_team_per_season
    expected = {
      "20122013"=>9,
      "20172018"=>4,
      "20132014"=>2,
      "20142015"=>1
    }

    assert_equal expected, @stat_tracker.total_wins_per_team_per_season("6")
  end

  def test_win_percentage_per_season
    expected = {
      "20122013"=>90.0,
      "20172018"=>57.14,
      "20132014"=>100.0,
      "20142015"=>25.0
    }

    assert_equal expected, @stat_tracker.win_percentage_per_season("6")
  end
end
