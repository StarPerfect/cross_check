class GameTeamsStats
  attr_reader :game_id,
              :team_id,
              :home_or_away,
              :won,
              :head_coach,
              :goals,
              :shots,
              :hits,
              :power_play_opportunities,
              :power_play_goals

  def initialize(row)
    @game_id                  = row[:game_id]
    @team_id                  = row[:team_id]
    @home_or_away             = row[:hoa]
    @won                      = row[:won] == "TRUE"
    @head_coach               = row[:head_coach]
    @goals                    = row[:goals].to_i
    @shots                    = row[:shots].to_i
    @hits                     = row[:hits].to_i
    @power_play_opportunities = row[:powerplayopportunities].to_i
    @power_play_goals         = row[:powerplaygoals].to_i
  end
end
