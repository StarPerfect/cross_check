require 'minitest/autorun'
require 'minitest/pride'
require './lib/star_tracker'

class StarTrackerTest < Minitest::Test
  def test_it_is_a_file
    skip
    assert File.exist?
  end

  def test_dummy_total_score
    total_score = []
    CSV.foreach('./test/dummy_data/dummy_game.csv', :headers => true, :col_sep => ',') do |row|
      total_score << row[6].to_i + row[7].to_i
    end

    biggest_blowout = total_score.max - total_score.min


    assert_equal 7, total_score.max
    assert_equal 1, total_score.min
    assert_equal 6, biggest_blowout
  end
end
