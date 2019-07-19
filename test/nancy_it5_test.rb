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

  def test_total_games_per_season
    assert_equal 8, @stat_tracker.total_games_per_season("20122013").length
  end

  def test_team_wins_per_season
    assert_equal ({"6"=>3, "3"=>1}), @stat_tracker.team_wins_per_season("20122013")
  end

  def test_team_total_games_per_season
    assert_equal ({"3"=>4, "6"=>4}), @stat_tracker.team_total_games_per_season("20122013")
  end

  def test_win_percentage_per_season
    assert_equal ({"3"=>25.0, "6"=>75.0}), @stat_tracker.win_percentage_per_season("20122013")
  end

  def test_team_total_shots_per_season
    assert_equal ({"3"=>128, "6"=>154}), @stat_tracker.team_total_shots_per_season("20122013")
  end

  def test_team_total_goals_per_season
    assert_equal ({"3"=>9, "6"=>13}), @stat_tracker.team_total_goals_per_season("20122013")
  end

  def test_shot_goal_ratio_per_team_per_season
    assert_equal ({"3"=>14.22, "6"=>11.85}), @stat_tracker.shot_goal_ratio_per_team_per_season("20122013")
  end
end
