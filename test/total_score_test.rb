require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require './modules/total_score'
require 'pry'

class TotalScoreModuleTest < Minitest::Test

  def setup
    game_path = './test/dummy_data/dummy_game.csv'
    team_path = './test/dummy_data/dummy_team_info.csv'
    game_teams_path = './test/dummy_data/dummy_game_teams_stats.csv'

    locations = {
      games: game_path,
      team_info: team_path,
      game_teams: game_teams_path
    }

    @stat_1 = StatTracker.from_csv(locations)
  end

  def test_dummy_total_score
    assert_equal 9, @stat_1.highest_total_score
    assert_equal 3, @stat_1.lowest_total_score
    assert_equal 6, @stat_1.biggest_blowout
  end
end
