require 'simplecov'
SimpleCov.start do
  add_filter "/test/"
end
require 'Minitest/autorun'
require 'Minitest/pride'
require './modules/game_statistics'
require './lib/game'
require './lib/game_teams_stats'
require './lib/stat_tracker'
require './lib/team_info'
require './modules/corina'
require 'csv'
