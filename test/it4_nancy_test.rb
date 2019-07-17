require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require './modules/it4_nancy'
require 'pry'

class It4NancyTest < Minitest::Test
  def setup
    files = {
      games: './test/dummy_data/dummy_game.csv',
      team_info: './test/dummy_data/dummy_team_info.csv',
      game_teams: './test/dummy_data/dummy_game_teams_stats.csv'
    }

    @stat_tracker= StatTracker.from_csv(files)
  end

  def test_team_info
    binding.pry
  end

  # def test_best_season
  # end

  # def test_worst_season
  #
  # end

end
