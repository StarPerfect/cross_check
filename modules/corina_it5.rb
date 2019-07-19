module CorinaIt5
  def most_hits
    num_of_hits = 0
    id = 0
    @game_teams.each do |team|
      require 'pry'; binding.pry
      if team.hits > num_of_hits
        num_of_hits = team.hits
        id = team.team_id
      end
    end
    get_team_name(id)
  end
end
