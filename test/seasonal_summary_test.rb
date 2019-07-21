require './test/test_helper'

class SeasonalSummaryTest < Minitest::Test
  def setup
    files = {
      games:      './test/dummy_data/dummy_game_post_2.csv',
      teams:      './test/dummy_data/dummy_team_info.csv',
      game_teams: './test/dummy_data/dummy_game_teams_stats.csv'
    }
    @stat_tracker = StatTracker.from_csv(files)
  end

  def test_seasonal_summary
    expected = {
      "20122013"=> {
        postseason: {
          :win_percentage=>1.0,
          :total_goals_scored=>10,
          :total_goals_against=>5,
          :average_goals_scored=>3.33,
          :average_goals_against=>1.67
        },
        :regular_season=> {
          :win_percentage=>0.67,
          :total_goals_scored=>8,
          :total_goals_against=>5,
          :average_goals_scored=>2.67,
          :average_goals_against=>1.67
        }
      },
      "20172018"=> {
        postseason: {
          :win_percentage=>0.67,
          :total_goals_scored=>14,
          :total_goals_against=>8,
          :average_goals_scored=>4.67,
          :average_goals_against=>2.67
        },
        :regular_season => {
          :win_percentage=>0.67,
          :total_goals_scored=>8,
          :total_goals_against=>5,
          :average_goals_scored=>2.67,
          :average_goals_against=>1.67
        }
      }
    }
    assert_equal expected, @stat_tracker.seasonal_summary('6')
  end
end
