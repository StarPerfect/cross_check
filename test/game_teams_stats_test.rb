require './test/test_helper'

class GameTeamsStatsTest < Minitest::Test
  def setup
    @game_teams_stats_data = CSV.read('./test/dummy_data/dummy_game_teams_stats.csv',
      headers: true,
      header_converters: :symbol
    )
    @stats = @game_teams_stats_data.map { |row| GameTeamsStats.new(row) }
    @stats_1 = @stats[0]
  end

  def test_game_team_stats_exists
    assert_instance_of GameTeamsStats, @stats_1
  end

  def test_attributes
    assert_equal '2012030221', @stats_1.game_id
    assert_equal '3', @stats_1.team_id
    assert_equal 'away', @stats_1.home_or_away
    assert_equal false, @stats_1.won
    assert_equal 'John Tortorella', @stats_1.head_coach
    assert_equal 2, @stats_1.goals
    assert_equal 35, @stats_1.shots
    assert_equal 44, @stats_1.hits
    assert_equal 3, @stats_1.power_play_opportunities
    assert_equal 0, @stats_1.power_play_goals
  end
end
