require './test/test_helper'


class SeasonSumTest < Minitest::Test
  def setup
    files = {
      games:      './test/dummy_data/dummy_game_3.csv',
      teams:  './test/dummy_data/dummy_team_info.csv',
      game_teams: './test/dummy_data/dummy_game_teams_stats.csv'
    }
    @stat_tracker = StatTracker.from_csv(files)
  end

  def test_seasonal_summary
    expected = {
      "20122013" => {
        :postseason=>{
          :win_percentage=>0.89,
          :total_goals_scored=>28,
          :total_goals_against=>12,
          :average_goals_scored=>3.11,
          :average_goals_against=>1.33
        },
        :regular_season=>{
          :win_percentage=>1.0,
          :total_goals_scored=>4,
          :total_goals_against=>2,
          :average_goals_scored=>4.0,
          :average_goals_against=>2.0
          }
        },
      "20172018"=>{
        :postseason=>{
          :win_percentage=>0.57,
          :total_goals_scored=>28,
          :total_goals_against=>20,
          :average_goals_scored=>4.0,
          :average_goals_against=>2.86
        },
        :regular_season=>{
          :win_percentage=>0,
          :total_goals_scored=>0,
          :total_goals_against=>0,
          :average_goals_scored=>0,
          :average_goals_against=>0
          }
        },
      "20132014"=>{
        :postseason=>{
          :win_percentage=>0,
          :total_goals_scored=>0,
          :total_goals_against=>0,
          :average_goals_scored=>0,
          :average_goals_against=>0
        },
        :regular_season=>{
          :win_percentage=>1.0,
          :total_goals_scored=>10,
          :total_goals_against=>3,
          :average_goals_scored=>5.0,
          :average_goals_against=>1.5
          }
        },
      "20142015"=>{
        :postseason=>{
          :win_percentage=>0,
          :total_goals_scored=>0,
          :total_goals_against=>0,
          :average_goals_scored=>0,
          :average_goals_against=>0
        },
        :regular_season=>{
          :win_percentage=>0.25,
          :total_goals_scored=>12,
          :total_goals_against=>15,
          :average_goals_scored=>3.0,
          :average_goals_against=>3.75
        }
      }
    }

    assert_equal expected, @stat_tracker.seasonal_summary("6")
  end
end
