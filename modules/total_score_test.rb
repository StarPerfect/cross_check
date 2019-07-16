require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require './modules/total_score'
require 'pry'

class StatTrackerTest < Minitest::Test

  def test_dummy_total_score
    stat_1 = StatTracker.from_csv
    assert_equal 9, stat_1.highest_total_score
    assert_equal 3, stat_1.lowest_total_score
    assert_equal 6, stat_1.biggest_blowout
  end
end
