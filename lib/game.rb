class Game
  attr_reader :game_id,
              :season,
              :type,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals,
              :outcome


  def initialize(row)
    @game_id                = row[:game_id]
    @season                 = row[:season]
    @type                   = row[:type]
    @away_team_id           = row[:away_team_id]
    @home_team_id           = row[:home_team_id]
    @away_goals             = row[:away_goals].to_i
    @home_goals             = row[:home_goals].to_i
    @outcome                = row[:outcome]
  end
end
