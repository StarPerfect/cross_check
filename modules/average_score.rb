module AverageScore

  def list_all_team_names
    @team_info.map(&:teamname)
  end
end
