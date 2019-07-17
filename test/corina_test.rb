require './test/test_helper'

class CorinaTest < Minitest::Test
  def setup
    files = {
      games:      './test/dummy_data/dummy_game.csv',
      team_info:      './test/dummy_data/dummy_team_info.csv',
      game_teams: './test/dummy_data/dummy_game_teams_stats.csv'
    }
    @stat_tracker = StatTracker.from_csv(files)
  end

  def test_count_of_teams
    assert_equal 33, @stat_tracker.count_of_teams
  end

  def test_winningest_team
    assert_equal , @stat_tracker.winningest_team
  end
end
