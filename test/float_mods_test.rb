require 'Minitest/autorun'
require 'Minitest/pride'
require './lib/stat_tracker'
require './modules/float_mods'

class FloatModsTest < Minitest::Test

  def setup
    game_path = './test/dummy_data/dummy_game.csv'
    team_path = './test/dummy_data/dummy_team_info.csv'
    game_teams_path = './test/dummy_data/dummy_game_teams_stats.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_percentage_home_wins
    assert_equal 58.33, @stat_tracker.percentage_home_wins
  end
end
