require './test/test_helper'

class CorinaIt4Test < Minitest::Test
  def setup
    files = {
      games:      './test/dummy_data/dummy_game.csv',
      teams:      './test/dummy_data/dummy_team_info.csv',
      game_teams: './test/dummy_data/dummy_game_teams_stats.csv'
    }
    @stat_tracker = StatTracker.from_csv(files)
  end

  def test_average_win_percentage
    assert_equal 87.5, @stat_tracker.average_win_percentage('Bruins')
  end

  def test_most_goals_scored
    assert_equal 6, @stat_tracker.most_goals_scored('Bruins')
  end

  def test_fewest_goals_scored
    assert_equal 2, @stat_tracker.fewest_goals_scored('Bruins')
  end
end
