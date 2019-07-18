require './test/test_helper'

class FentonIt4Test < Minitest::Test
  def setup
    files = {
      games:      './test/dummy_data/dummy_game_2.csv',
      team_info:  './test/dummy_data/dummy_team_info.csv',
      game_teams: './test/dummy_data/dummy_gt2.csv'
    }
    @stat_tracker = StatTracker.from_csv(files)
  end

  def test_times_played
    expected = {
      '3'  => 4,
      '5'  => 4,
      '14' => 4
    }
    assert_equal expected, @stat_tracker.times_played('6')
  end

  def test_wins_against
    expected = {
      '3'  => 3,
      '5'  => 4,
      '14' => 1
    }
    assert_equal expected, @stat_tracker.wins_against('6')
  end

  # def test_losses_to
  #   expected = {
  #     '3'  => 1,
  #     '5'  => 0,
  #     '14' => 3
  #   }
  #   assert_equal expected, @stat_tracker.losses_to('6')
  # end

  def test_win_percent_against
    expected = {
      '3'  => 0.75,
      '5'  => 1.0,
      '14' => 0.25
    }
    assert_equal expected, @stat_tracker.win_percent_against('6')
  end

  def test_favorite_opponent
    assert_equal 'Penguins', @stat_tracker.favorite_opponent('6')
  end

  def test_rival
    assert_equal 'Lightning', @stat_tracker.rival('6')
  end

  def test_biggest_team_blowout
    assert_equal 5, @stat_tracker.biggest_team_blowout('6')
  end

  def test_worst_loss
    assert_equal 3, @stat_tracker.worst_loss('6')
  end
end
