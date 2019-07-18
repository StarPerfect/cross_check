require 'simplecov'
SimpleCov.start do
  add_filter "/test/"
end
require 'Minitest/autorun'
require 'Minitest/pride'
require 'csv'
require './lib/stat_tracker'
require './lib/game'
require './lib/team_info'
require './lib/game_teams_stats'
require './modules/game_statistics'
require './modules/corina'
require './modules/fenton_it4'
require './modules/best_worst_o_and_d'
require './modules/average_score'
require 'csv'


