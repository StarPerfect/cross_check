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
    files = {
      games: './test/dummy_data/dummy_game_post.csv',
      teams: './test/dummy_data/dummy_team_info.csv',
      game_teams: './test/dummy_data/dummy_gt2.csv'
    }

    stat_tracker = StatTracker.from_csv(files)

    expected = {
      regular_season: {
        '4'  => { total: 1, wins: 1 },
        '5'  => { total: 2, wins: 0 },
        '7'  => { total: 1, wins: 1 },
        '9'  => { total: 1, wins: 1 },
        '14' => { total: 1, wins: 0 },
        '26' => { total: 1, wins: 0 },
        '28' => { total: 2, wins: 1 },
        '29' => { total: 1, wins: 1 },
        '30' => { total: 2, wins: 1 }
      },
      playoff_games: {
        '5'  => { total: 3, wins: 3 },
        '26' => { total: 3, wins: 1 },
        '28' => { total: 3, wins: 2 },
        '29' => { total: 3, wins: 0 }
      }
    }
    assert_equal expected, stat_tracker.win_percent_by_type('20132014')
  end

  def test_postseason_change
    files = {
      games: './test/dummy_data/dummy_game_post.csv',
      teams: './test/dummy_data/dummy_team_info.csv',
      game_teams: './test/dummy_data/dummy_gt2.csv'
    }
    stat_tracker = StatTracker.from_csv(files)

    expected = {
      '5'  => 1.0,
      '26' => 0.333,
      '28' => 0.167,
      '29' => (-1.0)
    }
    actual = stat_tracker.postseason_change('20132014')
    actual = actual.each {|team, diff| actual[team] = diff.round(3)}
    assert_equal expected, actual
  end

  def test_biggest_bust
    stat_tracker = StatTracker.new({})

    mock_data = {
      '5'  => 1.0,
      '26' => 0.333,
      '28' => 0.167,
      '29' => (-1.0)
    }

    stat_tracker.stubs(:postseason_change)
      .with('20132014')
      .returns(mock_data)
    stat_tracker.stubs(:get_team_name)
      .with('29')
      .returns('Blue Jackets')

    assert_equal 'Blue Jackets', stat_tracker.biggest_bust('20132014')
  end

  def test_biggest_surprise
    stat_tracker = StatTracker.new({})

    mock_data = {
      '5'  => 1.0,
      '26' => 0.333,
      '28' => 0.167,
      '29' => (-1.0)
    }

    stat_tracker.stubs(:postseason_change)
      .with('20132014')
      .returns(mock_data)
    stat_tracker.stubs(:get_team_name)
      .with('5')
      .returns('Penguins')

    assert_equal 'Penguins', stat_tracker.biggest_surprise('20132014')
  end

  def test_games_in_season
    actual = @stat_tracker.games_in_season("20122013")
    assert_equal 8, actual.length
    assert actual.all? { |obj| obj.class == GameTeamsStats }
  end

  def test_coach_win_percentage_per_season
    expected = {
      "John Tortorella" => 0.25,
      "Claude Julien" => 0.75
    }
    assert_equal expected, @stat_tracker.coach_win_percentage_per_season("20122013")
  end

  def test_winningest_coach
    assert_equal "Claude Julien", @stat_tracker.winningest_coach("20122013")
  end

  def test_worst_coach
    assert_equal "John Tortorella", @stat_tracker.worst_coach("20122013")
  end

  def test_most_accurate_team
    assert_equal "Bruins", @stat_tracker.most_accurate_team("20122013")
  end

  def test_shots_and_goals_per_season
    expected = {
      '3' => {shots: 128, goals: 9},
      '6' => {shots: 154, goals: 13}
    }
    assert_equal expected, @stat_tracker.shots_and_goals_per_season("20122013")
  end

  def test_shot_goal_ratio_per_team
    expected = {"3"=>0.0703, "6"=>0.0844}
    actual = @stat_tracker.shot_goal_ratio_per_team("20122013")
      .transform_values { |val| val.round(4) }

    assert_equal expected, actual
  end

  def test_least_accurate_team
    assert_equal "Rangers", @stat_tracker.least_accurate_team("20122013")
  end

  def test_team_hits
    expected = {
      '3' => 154,
      '6' => 139
    }
    assert_equal expected, @stat_tracker.team_hits('20122013')
  end

  def test_most_hits
    stat_tracker = StatTracker.new({})
    stat_tracker.stubs(:team_hits)
      .with('20122013')
      .returns({'3' => 154,'6' => 139})
    stat_tracker.stubs(:get_team_name)
      .with('3')
      .returns('Rangers')

    assert_equal 'Rangers', stat_tracker.most_hits("20122013")
  end

  def test_fewest_hits
    stat_tracker = StatTracker.new({})
    stat_tracker.stubs(:team_hits)
      .with('20122013')
      .returns({'3' => 154,'6' => 139})
    stat_tracker.stubs(:get_team_name)
      .with('6')
      .returns('Bruins')

    assert_equal 'Bruins', @stat_tracker.fewest_hits("20122013")
  end

  def test_power_play_goal_percentage
    assert_equal 0.18, @stat_tracker.power_play_goal_percentage("20122013")
  end
end
