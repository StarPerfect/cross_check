module CorinaIt4
  def get_team_id_from_name(name)
    @teams.find{ |team| team.team_name == name }.team_id
  end

  def average_win_percentage(team)
    id = get_team_id_from_name(team)
    (wins_per_team[id].to_f / team_total_games_from_games[id] * 100).round(2)
  end

  def most_goals_scored(team)
    id = get_team_id_from_name(team)
    max_score = 0
    @game_teams.each do |team|
      if team.team_id == id && team.goals > max_score
        max_score = team.goals
      end
    end
    max_score
  end

  def fewest_goals_scored(team)
    id = get_team_id_from_name(team)
    min_score = 100
    @game_teams.each do |team|
      if team.team_id == id && team.goals < min_score
        min_score = team.goals
      end
    end
    min_score
  end
end
