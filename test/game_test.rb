require './test/test_helper'

class GameTest < Minitest::Test
  def setup
    @game_data = CSV.read('./test/dummy_data/dummy_game.csv',
      headers: true,
      header_converters: :symbol
    )
    @game_info = @game_data.map { |row| Game.new(row) }
    @game_1 = @game_info[0]
  end

  def test_it_exists
    assert_instance_of Game, @game_1
  end

  def test_attributes
    assert_equal "2012030221", @game_1.game_id
    assert_equal "20122013", @game_1.season
    assert_equal "P", @game_1.type
    assert_equal "2013-05-16", @game_1.date_time
    assert_equal "3", @game_1.away_team_id
    assert_equal "6", @game_1.home_team_id
    assert_equal 2, @game_1.away_goals
    assert_equal 3, @game_1.home_goals
    assert_equal "home win OT", @game_1.outcome
    assert_equal "left", @game_1.home_rink_side_start
    assert_equal "TD Garden", @game_1.venue
    assert_equal "/api/v1/venues/null", @game_1.venue_link
    assert_equal "America/New_York", @game_1.venue_time_zone_id
    assert_equal (-4), @game_1.venue_time_zone_offset
    assert_equal "EDT", @game_1.venue_time_zone_tz
  end
end
