require 'simplecov'
SimpleCov.start do
  add_filter "/test/"
end
require 'Minitest/autorun'
require 'Minitest/pride'
require 'mocha/minitest'
require 'csv'
require './lib/stat_tracker'
require './lib/game'
require './lib/team_info'
require './lib/game_teams_stats'
require './modules/game_statistics'
require './modules/league_statistics'
require './modules/team_statistics'
require './modules/season_statistics'
require './modules/seasonal_summary'
require './modules/stat_helpers'
