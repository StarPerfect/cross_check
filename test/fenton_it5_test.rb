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
    skip
    expected = {
      regular_season: {
        '5'  => { total: 2, wins: 0 },
        '26' => { total: 2, wins: 1 },
        '28' => { total: 2, wins: 1 },
        '29' => { total: 3, wins: 2 },
        '4'  => { total: 1, wins: 1 },
        '9'  => { total: 1, wins: 0 },
        '30' => { total: 2, wins: 2 },
        '2'  => { total: 1, wins: 0 },
        '14' => { total: 1, wins: 0 },
        '7'  => { total: 1, wins: 0 },
      },
      playoff_games: {
        '5'  => { total: 3, wins: 3 },
        '26' => { total: 3, wins: 0 },
        '28' => { total: 3, wins: 2 },
        '29' => { total: 3, wins: 1 }
      }
    }
    assert_equal expected, @stat_tracker.win_percent_by_type('20132014')
  end

  def test_postseason_change
    skip
    expected = {
      '5'  => 1.0,
      '26' => (-0.167),
      '28' => 0.167,
      '29' => (-1.0)
    }
    actual = @stat_tracker.postseason_change('20132014')
    actual = actual.each {|team, diff| actual[team] = diff.round(3)}
    assert_equal expected, actual
  end

  def test_biggest_bust
    assert_equal 'Blue Jackets', @stat_tracker.biggest_bust('20132014')
  end

  def test_biggest_surprise
    assert_equal 'Penguins', @stat_tracker.biggest_surprise('20132014')
  end
end
