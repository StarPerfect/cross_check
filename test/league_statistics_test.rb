require './test/test_helper'

class LeagueStatisticsTest < Minitest::Test
  def setup
    files = {
      games:      './test/dummy_data/dummy_game.csv',
      teams:  './test/dummy_data/dummy_team_info.csv',
      game_teams: './test/dummy_data/dummy_game_teams_stats.csv'
    }
    @stat_tracker = StatTracker.from_csv(files)
  end

  def test_team_total_goals
    expected = {
      "3" => 10,
      "6" => 27,
      "5" => 2
    }
    assert_equal expected, @stat_tracker.team_total_goals
  end

  def test_team_avg_goals_per_game
    expected = {
      "3" => 2.0,
      "6" => 3.375,
      "5" => 0.667
    }
    assert_equal expected, @stat_tracker.team_avg_goals_per_game
  end

  def test_best_offense
    assert_equal "Bruins", @stat_tracker.best_offense
  end

  def test_worst_offense
    assert_equal "Penguins", @stat_tracker.worst_offense
  end

  def test_team_home_goals_allowed
    expected = {
      '3'  => 5,
      '6'  => 4,
      '20' => 8,
      '24' => 4,
      '16' => 4,
      '14' => 5
    }
    assert_equal expected, @stat_tracker.team_home_goals_allowed
  end

  def test_team_away_goals_allowed
    expected = {
      '3'  => 8,
      '6'  => 5,
      '20' => 6,
      '24' => 5,
      '16' => 5,
      '14' => 4
    }
    assert_equal expected, @stat_tracker.team_away_goals_allowed
  end

  def test_team_avg_goals_allowed
    expected = {
      '3'  => 3.25,
      '6'  => 2.25,
      '20' => 3.5,
      '24' => 2.25,
      '16' => 2.25,
      '14' => 2.25
    }
    assert_equal expected, @stat_tracker.team_avg_goals_allowed
  end

  def test_best_defense
    assert_equal "Bruins", @stat_tracker.best_defense
  end

  def test_worst_defense
    assert_equal "Flames", @stat_tracker.worst_defense
  end

  def test_away_team_goals
    expected = {
      '3' => 5,
      '5' => 1,
      '6' => 14
    }
    assert_equal expected, @stat_tracker.away_team_goals
  end

  def test_home_team_goals
    expected = {
      '3' => 5,
      '5' => 1,
      '6' => 13
    }
    assert_equal expected, @stat_tracker.home_team_goals
  end

  def test_away_team_total_games
    expected = {
      '3' => 3,
      '5' => 1,
      '6' => 4
    }
    assert_equal expected, @stat_tracker.away_team_total_games
  end

  def test_home_team_total_games
    expected = {
      '3' => 2,
      '5' => 2,
      '6' => 4
    }
    assert_equal expected, @stat_tracker.home_team_total_games
  end

  def test_away_team_avg_goals_per_game
    expected = {
      '3' => 1.667,
      '5' => 1.0,
      '6' => 3.5
    }
    assert_equal expected, @stat_tracker.away_team_avg_goals_per_game
  end

  def test_home_team_avg_goals_per_game
    expected = {
      '3' => 2.5,
      '5' => 0.5,
      '6' => 3.25
    }
    assert_equal expected, @stat_tracker.home_team_avg_goals_per_game
  end

  def test_highest_scoring_visitor
    assert_equal "Bruins", @stat_tracker.highest_scoring_visitor
  end

  def test_highest_scoring_home_team
    assert_equal "Bruins", @stat_tracker.highest_scoring_home_team
  end

  def test_lowest_scoring_visitor
    assert_equal "Penguins", @stat_tracker.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    assert_equal "Penguins", @stat_tracker.lowest_scoring_home_team
  end

  def test_count_of_teams
    files = {
      games:      './test/dummy_data/dummy_game.csv',
      teams:      './test/dummy_data/dummy_team_info.csv',
      game_teams: './test/dummy_data/dummy_game_teams_stats0.csv'
    }
    stat_tracker = StatTracker.from_csv(files)

    assert_equal 33, stat_tracker.count_of_teams
  end

  def test_away_team_avg_goals_per_game
    expected = {
      '3' => 1.667,
      '5' => 1.0,
      '6' => 3.5
    }
    assert_equal expected, @stat_tracker.away_team_avg_goals_per_game
  end

  def test_total_games_by_name
    expected = {
      'Rangers'  => 5,
      'Bruins'   => 8,
      'Penguins' => 3
    }
    assert_equal expected, @stat_tracker.total_games_by_name
  end

  def test_winningest_team
    files = {
      games:      './test/dummy_data/dummy_game.csv',
      teams:      './test/dummy_data/dummy_team_info.csv',
      game_teams: './test/dummy_data/dummy_game_teams_stats0.csv'
    }
    stat_tracker = StatTracker.from_csv(files)

    assert_equal 'Bruins', stat_tracker.winningest_team
  end

  def test_away_wins_by_id
    expected = {
      "3" =>{:a_games=>2, :a_wins=>0},
      "6" =>{:a_games=>2, :a_wins=>1},
      "20"=>{:a_games=>2, :a_wins=>0},
      "24"=>{:a_games=>2, :a_wins=>2},
      "16"=>{:a_games=>2, :a_wins=>1},
      "14"=>{:a_games=>2, :a_wins=>1}
    }
    assert_equal expected, @stat_tracker.away_wins_by_id
  end

  def test_home_wins_by_id
    expected = {
      "6" =>{:h_games=>2, :h_wins=>2},
      "3" =>{:h_games=>2, :h_wins=>1},
      "24"=>{:h_games=>2, :h_wins=>2},
      "20"=>{:h_games=>2, :h_wins=>0},
      "14"=>{:h_games=>2, :h_wins=>1},
      "16"=>{:h_games=>2, :h_wins=>1}
    }
    assert_equal expected, @stat_tracker.home_wins_by_id
  end

  def test_home_away_win_pct
    expected = {
      "6" =>{:home_pct=>1.0, :away_pct=>0.5},
      "3" =>{:home_pct=>0.5, :away_pct=>0.0},
      "24"=>{:home_pct=>1.0, :away_pct=>1.0},
      "20"=>{:home_pct=>0.0, :away_pct=>0.0},
      "14"=>{:home_pct=>0.5, :away_pct=>0.5},
      "16"=>{:home_pct=>0.5, :away_pct=>0.5}
    }
    assert_equal expected, @stat_tracker.home_away_win_pct
  end

  def test_best_fans
    files = {
      games:      './test/dummy_data/dummy_game_2.csv',
      teams:      './test/dummy_data/dummy_team_info.csv',
      game_teams: './test/dummy_data/dummy_game_teams_stats.csv'
    }
    stat_tracker = StatTracker.from_csv(files)

      assert_equal 'Rangers', stat_tracker.best_fans
  end

  def test_worst_fans
    files = {
      games:      './test/dummy_data/dummy_game.csv',
      teams:      './test/dummy_data/dummy_team_info.csv',
      game_teams: './test/dummy_data/dummy_game_teams_stats.csv'
    }
    stat_tracker = StatTracker.from_csv(files)

    assert_equal [], stat_tracker.worst_fans
  end
end
