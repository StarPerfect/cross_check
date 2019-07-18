require './test/test_helper'

class CorinaIt4Test < Minitest::Test
  def setup
    files = {
      games:      './test/dummy_data/dummy_game.csv',
      team_info:      './test/dummy_data/dummy_team_info.csv',
      game_teams: './test/dummy_data/dummy_game_teams_stats0.csv'
    }
    @stat_tracker = StatTracker.from_csv(files)
  end

  def test_average_win_percentage
    assert_equal @stat_tracker.average_win_percentage('Kings')
  end
end
