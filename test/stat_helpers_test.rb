require './test/test_helper'

class StatHelpersTest < Minitest::Test
  def setup
    files = {
      games:      './test/dummy_data/dummy_game.csv',
      teams:  './test/dummy_data/dummy_team_info.csv',
      game_teams: './test/dummy_data/dummy_game_teams_stats.csv'
    }
    @stat_tracker = StatTracker.from_csv(files)
  end

  def test_get_team_name
    assert_equal "Bruins", @stat_tracker.get_team_name("6")
    assert_equal "Flames", @stat_tracker.get_team_name("20")
    assert_equal "Rangers", @stat_tracker.get_team_name("3")
  end

  def test_get_team_id_from_name
    assert_equal '6', @stat_tracker.get_team_id_from_name('Bruins')
    assert_equal '20', @stat_tracker.get_team_id_from_name('Flames')
    assert_equal '3', @stat_tracker.get_team_id_from_name('Rangers')
  end

  def test_team_total_games_from_game_teams
    expected = {
      "3" => 5,
      "5" => 3,
      "6" => 8
    }
    assert_equal expected, @stat_tracker.team_total_games_from_games
  end

  def test_team_total_games_from_game_teams
    expected = {
      '3'  => 4,
      '6'  => 4,
      '20' => 4,
      '24' => 4,
      '16' => 4,
      '14' => 4
    }
    assert_equal expected, @stat_tracker.team_total_games_from_game_teams
  end
end
