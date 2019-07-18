module CorinaIt4
  def get_team_id_from_name(name)
    @team_info.find{ |team| team.team_name == name }.team_id
  end

  def average_win_percentage(team)
    id = get_team_id_from_name(team)
    (wins_per_team[id].to_f / team_total_games[id] * 100).round(2)
  end
end
