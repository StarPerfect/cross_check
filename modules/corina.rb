module Corina
  def count_of_teams
    @team_info.count
  end

  def winningest_team
    team_wins = Hash.new(0)
    @game_teams.each do |team|
      if team.won
       team_wins[team.team_id] += 1
      end
    end
    answer = team_wins.max_by{ |key, value| value }
    (@team_info.find{ |team| team.team_id == answer[0] }).teamname
  end
end
