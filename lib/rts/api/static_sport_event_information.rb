# frozen_string_literal: true

module Api
  module StaticSportEventInformation
    # Currently available sports.
    # GET /sports
    def sports
      get('sports')
    end

    # Currently available leagues.
    # GET /{sport}/leagues
    def leagues(sport:)
      get("#{sport}/leagues")
    end

    # List Available teams
    # GET /{sport}/teams
    def teams(sport:)
      get("#{sport}/teams")
    end

    # PLAYERS
    # GET /{sport}/players{?team_id} List Available players
    # team_id: number (optional), Example: 1, Filter players by team id
    # sport: string (required), Example: lol
    def players(sport:, team_id: nil)
      get("#{sport}/players?team_id=#{team_id}")
    end

    # TOURNAMENTS
    # Currently available tournaments.
    # GET/{sport}/tournaments{?date_from,date_to}
    # Example URI
    # GET /lol/tournaments?date_from=2016-01-16 00:00:00Z
    # &date_to=2016-01-1600:00:00Z
    # URI ParametersHide
    # date_from
    # date (optional) Example: 2016-01-16 00:00:00Z
    # date_to
    # date (optional) Example: 2016-01-16 00:00:00Z
    # sport
    # string (required) Example: lol
    def tournaments(sport:, date_from: nil, date_to: nil)
      get("#{sport}/tournaments?date_from=#{date_from}&date_to=#{date_to}")
    end

    # TOURNAMENT TIERS
    # List all possible tournament tiers.
    # GET/{sport}/tournament/tiers
    # Tournament tiers by tier id
    # GET/{sport}/tournament/tiers/{id}
    def tournament_tiers(sport:, id: nil)
      get("#{sport}/tournament/tiers/#{id}")
    end

    # Series
    # GET/{sport}/series{?tournament_id}
    def series(sport:, tournament_id: nil)
      get("#{sport}/series?tournament_id=#{tournament_id}")
    end

    # Series types
    # List All Series types
    # GET/{sport}/series/types
    def series_type(sport:)
      get("#{sport}/series/types")
    end

    # SERIES STATES
    # List all possible series states.
    # GET/{sport}/series/states
    def series_states(sport:, id: nil)
      get("#{sport}/series/states/#{id}")
    end

    # MATCHES
    # Matches for series. Shows only closed and resolved matches.
    # List All Matches in Series
    # GET/{sport}/matches{?tournament_id,series_id,league_id}
    def matches(sport:, tournament_id: nil, series_id: nil, league_id: nil)
      get("#{sport}/matches?tournament_id=#{tournament_id}&series_id=#{series_id}&league_id=#{league_id}")
    end

    # MATCH POSITIONS
    # Possible match positions e.g. for LOL it can be Top,Mid,Jungles...
    # GET/{sport}/match/positions
    def match_positions(sport:)
      get("#{sport}/match/positions")
    end

    # MATCH STATES
    # List all possible match states.
    # GET/{sport}/match/states
    def match_states(sport:)
      get("#{sport}/match/states")
    end

    # Markets
    # List all markets. Selection array is sorted by order of selections.
    def markets(sport:)
      get("#{sport}/markets")
    end

    # SELECTIONS
    # List all selections types
    # GET/{sport}/market/selections
    def market_selections(sport:)
      get("#{sport}/market/selections")
    end

    # CLOSE TIMES
    # List all market close times. It is in match time.
    # GET/{sport}/market/close_times

    def market_close_times(sport:)
      get("#{sport}/market/close_times")
    end

    # RESOLVE TIMES
    # List all market resolve times. It is in match time.
    # GET/{sport}/market/resolve_times

    def market_resolve_times(sport:)
      get("#{sport}/market/resolve_times")
    end

    # MARKET STATES
    # List all market states.
    # GET /{sport}/market/states

    def market_states(sport:)
      get("#{sport}/market/states")
    end
  end
end
