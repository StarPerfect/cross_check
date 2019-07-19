require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require './modules/nancy_it5'
require 'pry'

class NancyIt5Test < Minitest::Test
  def setup
    files = {
      games: './test/dummy_data/dummy_game.csv',
      teams: './test/dummy_data/dummy_team_info.csv',
      game_teams: './test/dummy_data/dummy_game_teams_stats.csv'
    }

    @stat_tracker= StatTracker.from_csv(files)
  end

  def test_winningest_coach
    binding.pry
  end
end
