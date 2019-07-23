require './test/test_helper'

class StatTrackerTest < Minitest::Test

  def setup
    files = {
      games:      './test/dummy_data/dummy_game.csv',
      teams:  './test/dummy_data/dummy_team_info.csv',
      game_teams: './test/dummy_data/dummy_game_teams_stats.csv'
    }
    @stat_tracker = StatTracker.from_csv(files)
  end

  def test_stat_tracker_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_attributes
    assert_equal 12, @stat_tracker.games.length
    assert_equal 16, @stat_tracker.game_teams.length
    assert_equal 33, @stat_tracker.teams.length

    assert @stat_tracker.games.all? {|object| object.class == Game}
    assert @stat_tracker.game_teams.all? {|object| object.class == GameTeamsStats}
    assert @stat_tracker.teams.all? {|object| object.class == TeamInfo}
  end  
end
