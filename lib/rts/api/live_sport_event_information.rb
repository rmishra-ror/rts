# frozen_string_literal: true

module Api
  module LiveSportEventInformation
    # LIVE MATCHES
    # Currently available matches.
    # GET/{sport}/live/matches{?league_id,tournament_id,series_id}
    def live_matches(sport:, league_id: nil, tournament_id: nil, series_id: nil)
      get("#{sport}/live/matches?league_id=#{league_id}&tournament_id=#{tournament_id}&series_id=#{series_id}")
    end

    # MATCH STATE
    # Current live match state. Resource always shows last sequence state,
    # if you don't set it. It provides complete match state for sequence,
    # so you can reconstruct your data, when you miss a lot of sequences.
    # GET/{sport}/live/matches/{id}/state{?sequence,expand}
    def live_match_state(sport:, id:, sequence: nil, expand: nil)
      get("#{sport}/live/matches/#{id}/state?sequence=#{sequence}&expand=#{expand}")
    end

    # MATCH FEED
    # Current live match feed. Resource always shows last sequence delta against previous one,
    # if you don't request specific one. Delta sequence represents changed markets and match info.
    # GET/{sport}/live/matches/{id}/feed{?sequence}
    def live_match_feed(sport:, id:, sequence: nil)
      get("#{sport}/live/matches/#{id}/feed?sequence=#{sequence}")
    end

    # MATCH STATISTICS
    # Current live match statistics. Resource always shows last sequence state,
    # if you don't set it. It provides complete match state for sequence,
    # so you can reconstruct your data, when you miss a lot of sequences.
    # GET/{sport}/live/matches/{id}/statistics/state{?sequence,expand}

    def live_match_statistics_state(sport:, id:, sequence: nil, expand: nil)
      get("#{sport}/live/matches/#{id}/statistics/state?sequence=#{sequence}?expand=#{expand}")
    end

    # MATCH STATISTICS FEED
    # Current live match statistics feed. Resource always shows last sequence delta against previous one,
    # if you don't request specific one. Delta sequence represents changed markets and match info.
    # GET/{sport}/live/matches/{id}/statistics/feed{?sequence}
    def live_match_statistics_feed(sport:, id:, sequence: nil)
      get("#{sport}/live/matches/#{id}/statistics/feed?sequence=#{sequence}")
    end

    # STATISTICS STATES
    # List all statistics states.
    # GET/{sport}/statistics/states
    def statistics_states(sport:)
      get("#{sport}/statistics/states")
    end

    # LIVE SERIES
    # Currently available live series.
    # GET/{sport}/live/series{?league_id,tournament_id}
    def live_series(sport:, league_id: nil, tournament_id: nil)
      get("#{sport}/live/series?league_id=#{league_id}&tournament_id=#{tournament_id}")
    end

    # SERIES STATE
    # Current live series state. Resource always shows last sequence state, if you don't set it.
    # GET/{sport}/live/series/{id}/state{?sequence,expand}
    def live_series_state(sport:, id:, sequence: nil, expand: nil)
      get("#{sport}/live/series/#{id}/state?sequence=#{sequence}&expand=#{expand}")
    end
    #  SERIES FEED
    # Current live series feed. Resource always shows last sequence delta against previous one,
    # if you don't request specific one. Delta sequence represents changed markets.
    # GET/{sport}/live/series/{id}/feed{?sequence}

    def live_series_feed(sport:, id:, sequence: nil)
      get("#{sport}/live/series/#{id}/feed?sequence=#{sequence}")
    end
  end
end
