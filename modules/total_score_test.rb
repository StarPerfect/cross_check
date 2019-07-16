require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require './modules/total_score'
require 'pry'

class StatTrackerTest < Minitest::Test

  def setup
    @stat_1 = StatTracker.from_csv
    @games = @stat_1.games
    @games.extend(TotalScore)
  end

  def test_dummy_total_score
    binding.pry
    assert_equal 9, @games.highest_total_score
    assert_equal 3, @games.lowest_total_score
    assert_equal 6, @games.biggest_blowout
  end
end
