require './test/test_helper'

class CorinaIt5Test < Minitest::Test
  def setup
    files = {
      games:      './test/dummy_data/dummy_game.csv',
      teams:      './test/dummy_data/dummy_team_info.csv',
      game_teams: './test/dummy_data/dummy_game_teams_stats.csv'
    }
    @stat_tracker = StatTracker.from_csv(files)
  end

  def test_most_hits
    assert_equal 'Bruins', @stat_tracker.most_hits("20122013")
  end

  def test_fewest_hits
    assert_equal 'Penguins', @stat_tracker.fewest_hits("20122013")
  end

  def test_power_play_goal_percentage
    assert_equal 0.15, @stat_tracker.power_play_goal_percentage("20132013")
  end
end
