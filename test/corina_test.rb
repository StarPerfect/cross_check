require './test/test_helper'

class CorinaTest < Minitest::Test
  def setup
    files = {
      games:      './test/dummy_data/dummy_game.csv',
      team_info:      './test/dummy_data/dummy_team_info.csv',
      game_teams: './data/game_teams_stats.csv'
    }
    @stat_tracker = StatTracker.from_csv(files)
  end

  def test_count_of_teams
    assert_equal 33, @stat_tracker.count_of_teams
  end

  def test_winningest_team
    assert_equal 'Bruins', @stat_tracker.winningest_team
  end

  def test_best_fans
    assert_equal 'Bruins', @stat_tracker.best_fans
  end

  def test_worst_fans
    assert_equal [], @stat_tracker.worst_fans
  end
end
