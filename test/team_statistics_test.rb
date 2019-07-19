require './test/test_helper'

class TeamStatisticsTest < Minitest::Test

  def test_team_info
    files = {
      games:      './test/dummy_data/dummy_game_3.csv',
      teams:  './test/dummy_data/dummy_team_info.csv',
      game_teams: './test/dummy_data/dummy_game_teams_stats.csv'
    }

    stat_tracker = StatTracker.from_csv(files)

    expected = {
      "team_id" => "6",
      "franchise_id" => "6",
      "short_name" => "Boston",
      "team_name" => "Bruins",
      "abbreviation" => "BOS",
      "link" => "/api/v1/teams/6"
    }
    assert_equal expected, stat_tracker.team_info("6")
  end

  def test_best_season
    files = {
      games:      './test/dummy_data/dummy_game_3.csv',
      teams:  './test/dummy_data/dummy_team_info.csv',
      game_teams: './test/dummy_data/dummy_game_teams_stats.csv'
    }

    stat_tracker = StatTracker.from_csv(files)

    assert_equal "20132014", stat_tracker.best_season("6")
  end

  def test_worst_season
    files = {
      games:      './test/dummy_data/dummy_game_3.csv',
      teams:  './test/dummy_data/dummy_team_info.csv',
      game_teams: './test/dummy_data/dummy_game_teams_stats.csv'
    }

    stat_tracker = StatTracker.from_csv(files)

    assert_equal "20142015", stat_tracker.worst_season("6")
  end

  def test_average_win_percentage
    files = {
      games:      './test/dummy_data/dummy_game.csv',
      teams:      './test/dummy_data/dummy_team_info.csv',
      game_teams: './test/dummy_data/dummy_game_teams_stats.csv'
    }

    stat_tracker = StatTracker.from_csv(files)

    assert_equal 87.5, stat_tracker.average_win_percentage('Bruins')
  end

  def test_most_goals_scored
    files = {
      games:      './test/dummy_data/dummy_game.csv',
      teams:      './test/dummy_data/dummy_team_info.csv',
      game_teams: './test/dummy_data/dummy_game_teams_stats.csv'
    }

    stat_tracker = StatTracker.from_csv(files)

    assert_equal 6, stat_tracker.most_goals_scored('Bruins')
  end

  def test_fewest_goals_scored
    files = {
      games:      './test/dummy_data/dummy_game.csv',
      teams:      './test/dummy_data/dummy_team_info.csv',
      game_teams: './test/dummy_data/dummy_game_teams_stats.csv'
    }

    stat_tracker = StatTracker.from_csv(files)

    assert_equal 2, stat_tracker.fewest_goals_scored('Bruins')
  end

  def test_times_played
    files = {
      games:      './test/dummy_data/dummy_game_2.csv',
      teams:  './test/dummy_data/dummy_team_info.csv',
      game_teams: './test/dummy_data/dummy_gt2.csv'
    }

    stat_tracker = StatTracker.from_csv(files)

    expected = {
      '3'  => 4,
      '5'  => 4,
      '14' => 4
    }
    assert_equal expected, stat_tracker.times_played('6')
  end

  def test_wins_against
    files = {
      games:      './test/dummy_data/dummy_game_2.csv',
      teams:  './test/dummy_data/dummy_team_info.csv',
      game_teams: './test/dummy_data/dummy_gt2.csv'
    }

    stat_tracker = StatTracker.from_csv(files)

    expected = {
      '3'  => 3,
      '5'  => 4,
      '14' => 1
    }
    assert_equal expected, stat_tracker.wins_against('6')
  end

  def test_win_percent_against
    files = {
      games:      './test/dummy_data/dummy_game_2.csv',
      teams:  './test/dummy_data/dummy_team_info.csv',
      game_teams: './test/dummy_data/dummy_gt2.csv'
    }

    stat_tracker = StatTracker.from_csv(files)

    expected = {
      '3'  => 0.75,
      '5'  => 1.0,
      '14' => 0.25
    }
    assert_equal expected, stat_tracker.win_percent_against('6')
  end

  def test_favorite_opponent
    files = {
      games:      './test/dummy_data/dummy_game_2.csv',
      teams:  './test/dummy_data/dummy_team_info.csv',
      game_teams: './test/dummy_data/dummy_gt2.csv'
    }

    stat_tracker = StatTracker.from_csv(files)

    assert_equal 'Penguins', stat_tracker.favorite_opponent('6')
  end

  def test_rival
    files = {
      games:      './test/dummy_data/dummy_game_2.csv',
      teams:  './test/dummy_data/dummy_team_info.csv',
      game_teams: './test/dummy_data/dummy_gt2.csv'
    }

    stat_tracker = StatTracker.from_csv(files)

    assert_equal 'Lightning', stat_tracker.rival('6')
  end

  def test_biggest_team_blowout
    files = {
      games:      './test/dummy_data/dummy_game_2.csv',
      teams:  './test/dummy_data/dummy_team_info.csv',
      game_teams: './test/dummy_data/dummy_gt2.csv'
    }

    stat_tracker = StatTracker.from_csv(files)

    assert_equal 5, stat_tracker.biggest_team_blowout('6')
  end

  def test_worst_loss
    files = {
      games:      './test/dummy_data/dummy_game_2.csv',
      teams:  './test/dummy_data/dummy_team_info.csv',
      game_teams: './test/dummy_data/dummy_gt2.csv'
    }

    stat_tracker = StatTracker.from_csv(files)

    assert_equal 3, stat_tracker.worst_loss('6')
  end

  def test_head_to_head
    files = {
      games:      './test/dummy_data/dummy_game_2.csv',
      teams:  './test/dummy_data/dummy_team_info.csv',
      game_teams: './test/dummy_data/dummy_gt2.csv'
    }

    stat_tracker = StatTracker.from_csv(files)

    expected = {
      'Rangers'  => 0.75,
      'Penguins'  => 1.0,
      'Lightning' => 0.25
    }
    assert_equal expected, stat_tracker.head_to_head('6')
  end
end
