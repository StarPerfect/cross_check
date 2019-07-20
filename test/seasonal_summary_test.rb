require './test/test_helper'

class SeasonalSummaryTest < Minitest::Test
  def setup
    files = {
      games:      './data/game.csv',
      teams:  './test/dummy_data/dummy_team_info.csv',
      game_teams: './data/game_teams_stats.csv'
    }
    @stat_tracker = StatTracker.from_csv(files)
  end

  def test_seasonal_sumamry
    expected = {
      "20162017" => {
        postseason: {
          :win_percentage=>0.64,
          :total_goals_scored=>60,
          :total_goals_against=>48,
          :average_goals_scored=>2.73,
          :average_goals_against=>2.18},
          :regular_season => {
            :win_percentage=>0.5,
            :total_goals_scored=>240,
            :total_goals_against=>224,
            :average_goals_scored=>2.93,
            :average_goals_against=>2.73
          }
        },
        "20172018" => {
          postseason: {
            :win_percentage=>0.54,
            :total_goals_scored=>41,
            :total_goals_against=>42,
            :average_goals_scored=>3.15,
            :average_goals_against=>3.23
          },
          :regular_season=>
          {:win_percentage=>0.65,
            :total_goals_scored=>267,
            :total_goals_against=>211,
            :average_goals_scored=>3.26,
            :average_goals_against=>2.57
          }
        },
        "20132014" => {
          postseason: {
            :win_percentage=>0.0,
            :total_goals_scored=>0,
            :total_goals_against=>0,
            :average_goals_scored=>0.0,
            :average_goals_against=>0.0
          },
          :regular_season=>
          {
            :win_percentage=>0.46,
            :total_goals_scored=>216,
            :total_goals_against=>242,
            :average_goals_scored=>2.63,
            :average_goals_against=>2.95
          }
        },
        "20122013" => {
          postseason: {
            :win_percentage=>0.0,
            :total_goals_scored=>0,
            :total_goals_against=>0,
            :average_goals_scored=>0.0,
            :average_goals_against=>0.0
          },
          :regular_season=>
          {
            :win_percentage=>0.33,
            :total_goals_scored=>111,
            :total_goals_against=>139,
            :average_goals_scored=>2.31,
            :average_goals_against=>2.9
          }
        },
        "20142015" => {
          postseason: {
            :win_percentage=>0.33,
            :total_goals_scored=>21,
            :total_goals_against=>19,
            :average_goals_scored=>3.5,
            :average_goals_against=>3.17
          },
          :regular_season=>
          {
            :win_percentage=>0.57,
            :total_goals_scored=>232,
            :total_goals_against=>208,
            :average_goals_scored=>2.83,
            :average_goals_against=>2.54
          }
        },
        "20152016" => {
          postseason: {
            :win_percentage=>0.5,
            :total_goals_scored=>31,
            :total_goals_against=>43,
            :average_goals_scored=>2.21,
            :average_goals_against=>3.07
          },
          :regular_season=>
          {
            :win_percentage=>0.5,
            :total_goals_scored=>228,
            :total_goals_against=>215,
            :average_goals_scored=>2.78,
            :average_goals_against=>2.62
          }
        }
      }

    assert_equal expected, @stat_tracker.seasonal_summary('18')
  end
end
