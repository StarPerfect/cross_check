module StatHelpers
  def get_team_name(id)
    @teams.find { |team| team.team_id == id }.team_name
  end

  def get_team_id_from_name(name)
  @teams.find{ |team| team.team_name == name }.team_id
  end
end
