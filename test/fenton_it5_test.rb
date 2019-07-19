require './test/test_helper'

class FentonIt5Test < Minitest::Test
  def setup
    files = {
      games:      './test/dummy_data/dummy_game_post.csv',
      teams:  './test/dummy_data/dummy_team_info.csv',
      game_teams: './test/dummy_data/dummy_gt2.csv'
    }
    @stat_tracker = StatTracker.from_csv(files)
  end

  def test_win_percent_by_type
    expected = {
      regular_season: {
        '3' => { total: 5, wins: 1 },
        '5' => { total: 7, wins: 3 },
        '6' => { total: 8, wins: 6 }
      },
      playoff_games: {
        '3' => { total: 5, wins: 1 },
        '5' => { total: 4, wins: 0 },
        '6' => { total: 9, wins: 8 }
      }
    }
    assert_equal expected, @stat_tracker.win_percent_by_type
  end

  def test_postseason_change
    expected = {
      "3" => 0.0,
      "6" => 0.139,
      "5" => -0.429
    }
    actual = @stat_tracker.postseason_change
    actual = actual.each {|team, diff| actual[team] = diff.round(3)}
    assert_equal expected, actual
  end

  def test_biggest_bust
    assert_equal 'Penguins', @stat_tracker.biggest_bust
  end

  def test_biggest_surprise
    assert_equal 'Bruins', @stat_tracker.biggest_surprise
  end
end
