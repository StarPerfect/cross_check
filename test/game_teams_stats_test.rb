require './test/test_helper'
require 'Minitest/autorun'
require 'Minitest/pride'
require_relative '../lib/game_teams_stats'

class GameTeamsStatsTest < Minitest::Test
  def setup
    @stats = GameTeamsStats.new(
      game_id: '2012030221',
      team_id: '3',
      home_or_away: 'away',
      won: 'FALSE',
      settled_in: 'OT',
      head_coach: 'John Tortorella',
      goals: '2',
      shots: '35',
      hits: '44',
      pim: '8',
      power_play_opportunities: '3',
      power_play_goals: '0',
      face_off_win_percentage: '44.8',
      giveaways: '17',
      takeaways: '7',
      )
  end

  def test_game_team_stats_exists
    assert_instance_of GameTeamsStats, @stats
  end

  def test_attributes
    assert_equal '2012030221', @stats.game_id
    assert_equal '3', @stats.team_id
    assert_equal 'away', @stats.home_or_away
    assert_equal false, @stats.won
    assert_equal 'OT', @stats.settled_in
    assert_equal 'John Tortorella', @stats.head_coach
    assert_equal 2, @stats.goals
    assert_equal 35, @stats.shots
    assert_equal 44, @stats.hits
    assert_equal 8, @stats.pim
    assert_equal 3, @stats.power_play_opportunities
    assert_equal 0, @stats.power_play_goals
    assert_equal 44.8, @stats.face_off_win_percentage
    assert_equal 17, @stats.giveaways
    assert_equal 7, @stats.takeaways
  end
end
