require 'Minitest/autorun'
require 'Minitest/pride'
require './lib/stat_tracker'
require './modules/float_mods'

class FloatModsTest < Minitest::Test
  include FloatMods
  def setup
    @stat_tracker = StatTracker.from_csv(games: './test/dummy_data/dummy_game.csv')
    @game_data = @stat_tracker[:games]
  end

  def test_percentage_home_wins
    assert_equal 0.583333, percentage_home_wins
  end
end
