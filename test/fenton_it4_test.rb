require './test/test_helper'

class FentonIt4Test < Minitest::Test
  def test_success_at_home
    def setup
      files = {
        games:      './test/dummy_data/dummy_game.csv',
        team_info:  './test/dummy_data/dummy_team_info.csv',
        game_teams: './test/dummy_data/dummy_game_teams_stats.csv'
      }
      @stat_tracker = StatTracker.from_csv(files)
    end
  end
  def test_favorite_opponent
  end
end
