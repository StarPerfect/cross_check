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
    stat_tracker = StatTracker.new({})

    mock_wins = {
      "20122013"=>9,
      "20172018"=>4,
      "20132014"=>2,
      "20142015"=>1
    }

    mock_totals = {
      "20122013"=>10,
      "20172018"=>7,
      "20132014"=>2,
      "20142015"=>4
    }

    stat_tracker.stubs(:total_wins_per_team_per_season)
      .with('6')
      .returns(mock_wins)

    stat_tracker.stubs(:total_games_per_team_per_season)
      .with('6')
      .returns(mock_totals)

    assert_equal "20132014", stat_tracker.best_season("6")
  end

  def test_worst_season
    stat_tracker = StatTracker.new({})

    mock_wins = {
      "20122013"=>9,
      "20172018"=>4,
      "20132014"=>2,
      "20142015"=>1
    }

    mock_totals = {
      "20122013"=>10,
      "20172018"=>7,
      "20132014"=>2,
      "20142015"=>4
    }

    stat_tracker.stubs(:total_wins_per_team_per_season)
      .with('6')
      .returns(mock_wins)

    stat_tracker.stubs(:total_games_per_team_per_season)
      .with('6')
      .returns(mock_totals)

    assert_equal "20142015", stat_tracker.worst_season("6")
  end

  def test_total_games_per_team
    files = {
      games:      './test/dummy_data/dummy_game_3.csv',
      teams:  './test/dummy_data/dummy_team_info.csv',
      game_teams: './test/dummy_data/dummy_game_teams_stats.csv'
    }

    stat_tracker = StatTracker.from_csv(files)

   assert_equal 23, stat_tracker.total_games_per_team("6").length
  end

  def test_total_games_per_team_per_season
   files = {
     games:      './test/dummy_data/dummy_game_3.csv',
     teams:  './test/dummy_data/dummy_team_info.csv',
     game_teams: './test/dummy_data/dummy_game_teams_stats.csv'
   }

   stat_tracker = StatTracker.from_csv(files)

   expected = {
     "20122013"=>10,
     "20172018"=>7,
     "20132014"=>2,
     "20142015"=>4
   }

   assert_equal expected, stat_tracker.total_games_per_team_per_season("6")
 end

 def test_total_wins_per_team_per_season
   files = {
     games:      './test/dummy_data/dummy_game_3.csv',
     teams:  './test/dummy_data/dummy_team_info.csv',
     game_teams: './test/dummy_data/dummy_game_teams_stats.csv'
   }

   stat_tracker = StatTracker.from_csv(files)

   expected = {
     "20122013"=>9,
     "20172018"=>4,
     "20132014"=>2,
     "20142015"=>1
   }

   assert_equal expected, stat_tracker.total_wins_per_team_per_season("6")
 end

  def test_average_win_percentage
    files = {
      games:      './test/dummy_data/dummy_game.csv',
      teams:      './test/dummy_data/dummy_team_info.csv',
      game_teams: './test/dummy_data/dummy_game_teams_stats.csv'
    }

    stat_tracker = StatTracker.from_csv(files)

    assert_equal 0.88, stat_tracker.average_win_percentage('6')
  end

  def test_most_goals_scored
    files = {
      games:      './test/dummy_data/dummy_game.csv',
      teams:      './test/dummy_data/dummy_team_info.csv',
      game_teams: './test/dummy_data/dummy_game_teams_stats.csv'
    }

    stat_tracker = StatTracker.from_csv(files)

    assert_equal 6, stat_tracker.most_goals_scored('6')
  end

  def test_fewest_goals_scored
    files = {
      games:      './test/dummy_data/dummy_game.csv',
      teams:      './test/dummy_data/dummy_team_info.csv',
      game_teams: './test/dummy_data/dummy_game_teams_stats.csv'
    }

    stat_tracker = StatTracker.from_csv(files)

    assert_equal 2, stat_tracker.fewest_goals_scored('6')
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
    stat_tracker = StatTracker.new({})

    mock_wins = {"3"=>3, "5"=>4, "14"=>1}
    mock_times_played = {'3' => 4, '5' => 4, '14' => 4}
    expected = {'3' => 0.75, '5' => 1.0, '14' => 0.25}

    stat_tracker.stubs(:wins_against)
      .with('6')
      .returns(mock_wins)

    stat_tracker.stubs(:times_played)
      .with('6')
      .returns(mock_times_played)

    assert_equal expected, stat_tracker.win_percent_against('6')
  end

  def test_favorite_opponent
    stat_tracker = StatTracker.new({})

    mock_data = {'3' => 0.75, '5' => 1.0, '14' => 0.25}

    stat_tracker.stubs(:win_percent_against)
      .with('6')
      .returns(mock_data)

    stat_tracker.stubs(:get_team_name)
      .with('5')
      .returns('Penguins')

    assert_equal 'Penguins', stat_tracker.favorite_opponent('6')
  end

  def test_rival
    stat_tracker = StatTracker.new({})

    mock_data = {'3' => 0.75, '5' => 1.0, '14' => 0.25}

    stat_tracker.stubs(:win_percent_against)
    .with('6')
    .returns(mock_data)

    stat_tracker.stubs(:get_team_name)
    .with('14')
    .returns('Lightning')

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
