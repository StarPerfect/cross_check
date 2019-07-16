require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require './module/total_score'
require 'pry'

class StatTrackerTest < Minitest::Test

  def setup
    @dataset = StatTracker.from_csv({game: './dummy_data/dummy_game.csv'})
    @data = @dataset[:game]
    @data.extend(TotalScore)
  end

  def test_dummy_total_score
    assert_equal 7, @data.highest_total_score
    assert_equal 1, @data.lowest_total_score
    assert_equal 6, @data.biggest_blowout
  end
end
