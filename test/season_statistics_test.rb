require './test/test_helper'

class SeasonStatisticsTest < Minitest::Test
  def setup
    files = {
      games: './test/dummy_data/dummy_game.csv',
      teams: './test/dummy_data/dummy_team_info.csv',
      game_teams: './test/dummy_data/dummy_game_teams_stats.csv'
    }

    @stat_tracker = StatTracker.from_csv(files)
  end

  def test_win_percent_by_type
    skip
    files = {
      games:      './test/dummy_data/dummy_game_post.csv',
      teams:  './test/dummy_data/dummy_team_info.csv',
      game_teams: './test/dummy_data/dummy_gt2.csv'
    }

    stat_tracker = StatTracker.from_csv(files)

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
    assert_equal expected, stat_tracker.win_percent_by_type('20132014')
  end

  def test_postseason_change
    skip
    files = {
      games:      './test/dummy_data/dummy_game_post.csv',
      teams:  './test/dummy_data/dummy_team_info.csv',
      game_teams: './test/dummy_data/dummy_gt2.csv'
    }
    stat_tracker = StatTracker.from_csv(files)

    expected = {
      '5'  => 1.0,
      '26' => (-0.167),
      '28' => 0.167,
      '29' => (-1.0)
    }
    actual = stat_tracker.postseason_change('20132014')
    actual = actual.each {|team, diff| actual[team] = diff.round(3)}
    assert_equal expected, actual
  end

  def test_biggest_bust
    files = {
      games:      './test/dummy_data/dummy_game_post.csv',
      teams:  './test/dummy_data/dummy_team_info.csv',
      game_teams: './test/dummy_data/dummy_gt2.csv'
    }
    stat_tracker = StatTracker.from_csv(files)

    assert_equal 'Blue Jackets', stat_tracker.biggest_bust('20132014')
  end

  def test_biggest_surprise
    files = {
      games:      './test/dummy_data/dummy_game_post.csv',
      teams:  './test/dummy_data/dummy_team_info.csv',
      game_teams: './test/dummy_data/dummy_gt2.csv'
    }
    stat_tracker = StatTracker.from_csv(files)

    assert_equal 'Penguins', stat_tracker.biggest_surprise('20132014')
  end

  def test_winningest_coach
    assert_equal "Claude Julien", @stat_tracker.winningest_coach("20122013")
  end

  def test_worst_coach
    rfiles = {
      game_teams: './data/game_teams_stats.csv',
      games: './data/game.csv',
      teams: './data/team_info.csv'
    }

    stat_tracker = StatTracker.from_csv(rfiles)
    assert_equal "John Tortorella", @stat_tracker.worst_coach("20122013")
  end

  def test_most_accurate_team
    assert_equal "Rangers", @stat_tracker.most_accurate_team("20122013")
  end

  def test_least_accurate_team
    assert_equal "Bruins", @stat_tracker.least_accurate_team("20122013")
  end

  def test_total_games_per_season
    assert_equal 8, @stat_tracker.total_games_per_season("20122013").length
  end

  def test_team_wins_per_season
    assert_equal ({"6"=>3, "3"=>1}), @stat_tracker.team_wins_per_season("20122013")
  end

  def test_team_total_games_per_season
    assert_equal ({"3"=>4, "6"=>4}), @stat_tracker.team_total_games_per_season("20122013")
  end

  def test_win_percentage_per_season
    assert_equal ({"3"=>0.25, "6"=>0.75}), @stat_tracker.win_percentage_per_season("20122013")
  end

  def test_team_total_shots_per_season
    assert_equal ({"3"=>128, "6"=>154}), @stat_tracker.team_total_shots_per_season("20122013")
  end

  def test_team_total_goals_per_season
    assert_equal ({"3"=>9, "6"=>13}), @stat_tracker.team_total_goals_per_season("20122013")
  end

  def test_shot_goal_ratio_per_team_per_season
    assert_equal ({"3"=>14.22, "6"=>11.85}), @stat_tracker.shot_goal_ratio_per_team_per_season("20122013")
  end

  def test_most_hits
    assert_equal 'Rangers', @stat_tracker.most_hits("20122013")
  end

  def test_fewest_hits
    assert_equal 'Bruins', @stat_tracker.fewest_hits("20122013")
  end

  def test_power_play_goal_percentage
    assert_equal 0.18, @stat_tracker.power_play_goal_percentage("20122013")
  end
end
