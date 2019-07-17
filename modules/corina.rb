module Corina
  def count_of_teams
    @team_info.count
  end

  def winningest_team
    team_wins = Hash.new(0)
    @game_teams.map do |team|
      if @game_teams.won
       team_wins[@game_teams.team_id] += 1
      end
    end
    require 'pry'; binding.pry
        # / @games.count
  end
end
