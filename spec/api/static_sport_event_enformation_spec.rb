require 'spec_helper'

RSpec.describe 'RTS::Api::StaticSportEventInformation' do
  before do
    @client = RTS::Client.new(api_key: 'b2871665-9496-4ea7-896f-99db00907f2b',
                              client_certificate_path: 'spec/fixtures/rts.crt',
                              client_key_path: 'spec/fixtures/rts.key')
  end

  describe 'GET sports' do
    it 'should get get the all available sports' do
      VCR.use_cassette('static_sport_event_enformation') do
        response = @client.sports
        expect(response).to include({ 'id' => 1, 'name' => 'League of Legends', 'shortcut' => 'lol', 'key' => 'lol' })
      end
    end

    it 'should raise error if api_key is incorrect' do
      VCR.use_cassette('static_sport_event_enformation') do
        @client.api_key = 'fake_api_key'
        expect { @client.sports }.to raise_error(RTS::Error::NotFound)
      end
    end
  end

  describe 'GET {sport}/leagues' do
    it 'should get the all available leagues' do
      VCR.use_cassette('static_sport_event_enformation') do
        response = @client.leagues(sport: 'lol')
        expect(response).to include({
                                      'id' => 1, 'shortcut' => 'na-lcs', 'name' => 'NA LCS', 'region' => 'NA',
                                      'description' => 'TOP 10 teams in North American region face against each other',
                                      'tournaments' => [1]
                                    })
      end
    end
  end

  describe 'GET {sport}/teams' do
    it 'should get the all available teams' do
      VCR.use_cassette('static_sport_event_enformation') do
        response = @client.teams(sport: 'lol')
        expect(response).to include(
          {
            'id' => 38, 'shortcut' => 'AFS', 'name' => 'Afreeca Freecs',
            'players' => [
              {
                'id' => 264, 'from_date' => '2018-01-24T12:31:24.954Z', 'to_date' => nil, 'active' => true
              },
              {
                'id' => 265, 'from_date' => '2018-01-24T12:31:25.306Z', 'to_date' => nil, 'active' => true
              }
            ]
          }
        )
      end
    end
  end

  describe 'GET /{sport}/players{?team_id}' do
    it 'should get the all available players' do
      VCR.use_cassette('static_sport_event_enformation') do
        response = @client.players(sport: 'lol')
        expect(response).to include({ 'id' => 5, 'first_name' => 'Brian', 'last_name' => 'Wyllie',
                                      'nickname' => 'OddOne', 'team_id' => 1, 'active' => true })
      end
    end

    it 'should get the all available players filter by team_id' do
      VCR.use_cassette('static_sport_event_enformation') do
        response = @client.players(sport: 'lol', team_id: 2)
        expect(response).to eq(
          [{ 'id' => 9, 'first_name' => 'An', 'last_name' => 'Le', 'nickname' => 'Balls',
             'team_id' => 2, 'active' => true },
           { 'id' => 10, 'first_name' => 'Nicolaj', 'last_name' => 'Jensen', 'nickname' => 'Jensen',
             'team_id' => 2, 'active' => true },
           { 'id' => 11, 'first_name' => 'Zachary ', 'last_name' => 'Scuderi', 'nickname' => 'Sneaky',
             'team_id' => 2, 'active' => true },
           { 'id' => 12, 'first_name' => 'Hai', 'last_name' => 'Lam', 'nickname' => 'Hai',
             'team_id' => 2, 'active' => true },
           { 'id' => 13, 'first_name' => 'William', 'last_name' => 'Hartman', 'nickname' => 'Meteos',
             'team_id' => 2, 'active' => true },
           { 'id' => 14, 'first_name' => 'Michael', 'last_name' => 'Kurylo', 'nickname' => 'Bunny FuFuu',
             'team_id' => 2, 'active' => true },
           { 'id' => 15, 'first_name' => 'Yoon-jae', 'last_name' => 'Lee', 'nickname' => 'Rush',
             'team_id' => 2, 'active' => true }]
        )
      end
    end
  end

  describe 'GET {sport}/tournament/tiers/{id}' do
    it 'should get the all available tournament tiers' do
      VCR.use_cassette('static_sport_event_enformation') do
        response = @client.tournament_tiers(sport: 'lol')
        expect(response).to eq([
                                 { 'id' => 1, 'name' => '1' },
                                 { 'id' => 2, 'name' => '2' },
                                 { 'id' => 3, 'name' => '3' }
                               ])
      end
    end

    it 'should get the all available tournament tiers filter by tier id' do
      VCR.use_cassette('static_sport_event_enformation') do
        response = @client.tournament_tiers(sport: 'lol', id: 1)
        expect(response).to eq({ 'id' => 1, 'name' => '1' })
      end
    end
  end

  describe 'GET/{sport}/series{?tournament_id}' do
    it 'should get the all available series of the sport' do
      VCR.use_cassette('static_sport_event_enformation') do
        response = @client.series(sport: 'lol')
        expect(response).to include({
                                      'id' => 674,
                                      'planned_start' => '2019-01-25T19:22:58.966Z',
                                      'series_type_id' => 4,
                                      'series_state_id' => 4,
                                      'tournament_id' => 1,
                                      'win_team_id' => 26,
                                      'home_team_id' => 26,
                                      'away_team_id' => 24,
                                      'league_id' => 1
                                    })
      end
    end

    it 'should get the all available series filter by tournament_id' do
      VCR.use_cassette('static_sport_event_enformation') do
        response = @client.series(sport: 'lol', tournament_id: 1)
        expect(response).to include({
                                      'id' => 674,
                                      'planned_start' => '2019-01-25T19:22:58.966Z',
                                      'series_type_id' => 4,
                                      'series_state_id' => 4,
                                      'tournament_id' => 1,
                                      'win_team_id' => 26,
                                      'home_team_id' => 26,
                                      'away_team_id' => 24,
                                      'league_id' => 1
                                    })
      end
    end
  end

  describe 'GET/{sport}/series/types' do
    it 'should get the all available series types of the sport' do
      VCR.use_cassette('static_sport_event_enformation') do
        response = @client.series_types(sport: 'lol')
        expect(response).to eq([
                                 { 'id' => 1, 'name' => 'best_of_1', 'number_of_matches' => 1 },
                                 { 'id' => 2, 'name' => 'best_of_2', 'number_of_matches' => 2 },
                                 { 'id' => 3, 'name' => 'best_of_3', 'number_of_matches' => 3 },
                                 { 'id' => 4, 'name' => 'best_of_5', 'number_of_matches' => 5 }
                               ])
      end
    end
  end

  describe 'GET/{sport}/series/states' do
    it 'should get the all available series states' do
      VCR.use_cassette('static_sport_event_enformation') do
        response = @client.series_states(sport: 'lol')
        expect(response).to eq([
                                 { 'id' => 1, 'state' => 'not_started' },
                                 { 'id' => 2, 'state' => 'started' },
                                 { 'id' => 3, 'state' => 'cancelled' },
                                 { 'id' => 4, 'state' => 'closed' }
                               ])
      end
    end

    it 'should get the all available series states filter by id' do
      VCR.use_cassette('static_sport_event_enformation') do
        response = @client.series_states(sport: 'lol', id: 1)
        expect(response).to include({ 'id' => 1, 'state' => 'not_started' })
      end
    end
  end

  describe 'GET/{sport}/matches{?tournament_id,series_id,league_id}' do
    it 'should get the all available matches of the sport' do
      VCR.use_cassette('static_sport_event_enformation') do
        response = @client.matches(sport: 'lol')
        expect(response).to include({
                                      'id' => 1024,
                                      'series_id' => 674,
                                      'series_match_sequence' => 1,
                                      'start_date' => '2019-01-25T19:22:59.060Z',
                                      'end_date' => '2019-01-25T19:42:11.718Z',
                                      'dark_team_id' => 26,
                                      'light_team_id' => 24,
                                      'win_team_id' => 26,
                                      'league_id' => 1,
                                      'tournament_id' => 1
                                    })
      end
    end

    it 'should get the all available matches filter by league_id' do
      VCR.use_cassette('static_sport_event_enformation') do
        response = @client.matches(sport: 'lol', league_id: 1)
        expect(response).to include({
                                      'id' => 1024,
                                      'series_id' => 674,
                                      'series_match_sequence' => 1,
                                      'start_date' => '2019-01-25T19:22:59.060Z',
                                      'end_date' => '2019-01-25T19:42:11.718Z',
                                      'dark_team_id' => 26,
                                      'light_team_id' => 24,
                                      'win_team_id' => 26,
                                      'league_id' => 1,
                                      'tournament_id' => 1
                                    })
      end
    end

    it 'should get the all available matches filter by tournament_id' do
      VCR.use_cassette('static_sport_event_enformation') do
        response = @client.matches(sport: 'lol', tournament_id: 1)
        expect(response).to include({
                                      'id' => 1024,
                                      'series_id' => 674,
                                      'series_match_sequence' => 1,
                                      'start_date' => '2019-01-25T19:22:59.060Z',
                                      'end_date' => '2019-01-25T19:42:11.718Z',
                                      'dark_team_id' => 26,
                                      'light_team_id' => 24,
                                      'win_team_id' => 26,
                                      'league_id' => 1,
                                      'tournament_id' => 1
                                    })
      end
    end

    it 'should get the all available matches filter by series_id' do
      VCR.use_cassette('static_sport_event_enformation') do
        response = @client.matches(sport: 'lol', series_id: 674)
        expect(response).to eq([{
                                 'id' => 1024,
                                 'series_id' => 674,
                                 'series_match_sequence' => 1,
                                 'start_date' => '2019-01-25T19:22:59.060Z',
                                 'end_date' => '2019-01-25T19:42:11.718Z',
                                 'dark_team_id' => 26,
                                 'light_team_id' => 24,
                                 'win_team_id' => 26,
                                 'league_id' => 1,
                                 'tournament_id' => 1
                               }])
      end
    end
  end

  describe 'GET/{sport}/match/positions' do
    it 'should get the all possible match positions of the sport' do
      VCR.use_cassette('static_sport_event_enformation') do
        response = @client.match_positions(sport: 'lol')
        expect(response).to eq([
                                 { 'id' => 1, 'name' => 'top_lane' },
                                 { 'id' => 2, 'name' => 'jungle' },
                                 { 'id' => 3, 'name' => 'middle_lane' },
                                 { 'id' => 4, 'name' => 'marksman' },
                                 { 'id' => 5, 'name' => 'support' }
                               ])
      end
    end
  end

  describe 'GET/{sport}/match/states' do
    it 'should get the all possible match states of the sport' do
      VCR.use_cassette('static_sport_event_enformation') do
        response = @client.match_states(sport: 'lol')
        expect(response).to eq([
                                 { 'id' => 1, 'name' => 'not_started', 'description' => nil },
                                 { 'id' => 2, 'name' => 'live', 'description' => nil },
                                 { 'id' => 3, 'name' => 'ended', 'description' => nil },
                                 { 'id' => 4, 'name' => 'closed', 'description' => nil },
                                 { 'id' => 5, 'name' => 'paused', 'description' => nil },
                                 { 'id' => 6, 'name' => 'cancelled', 'description' => nil },
                                 { 'id' => 7, 'name' => 'postponed', 'description' => nil },
                                 { 'id' => 8, 'name' => 'delayed', 'description' => nil },
                                 { 'id' => 9, 'name' => 'started', 'description' => nil }
                               ])
      end
    end
  end

  describe 'GET/{sport}/markets' do
    it 'should get the all available markets of the sport' do
      VCR.use_cassette('static_sport_event_enformation') do
        response = @client.markets(sport: 'lol')
        expect(response).to include({
                                      'id' => 1,
                                      'name' => 'MatchDuration',
                                      'description' => 'Duration in minutes (rounded)',
                                      'market_close_time_id' => 5,
                                      'market_resolve_time_id' => nil,
                                      'match_position_id' => nil,
                                      'home_team' => nil,
                                      'selections' => [1, 2, 3]
                                    })
      end
    end
  end

  describe 'GET/{sport}/market/selections' do
    it 'should get the all available selections types of the sport' do
      VCR.use_cassette('static_sport_event_enformation') do
        response = @client.market_selections(sport: 'lol')
        expect(response).to include({ 'id' => 1, 'lower_bound' => 0, 'name' => '0:00-33:00', 'upper_bound' => 1980 })
      end
    end
  end

  describe 'GET/{sport}/market/close_times' do
    it 'should get the all available market close times of the sport' do
      VCR.use_cassette('static_sport_event_enformation') do
        response = @client.market_close_times(sport: 'lol')
        expect(response).to eq([
                                 { 'id' => 1, 'match_time' => 420 },
                                 { 'id' => 2, 'match_time' => 720 },
                                 { 'id' => 3, 'match_time' => 1020 },
                                 { 'id' => 4, 'match_time' => 1320 },
                                 { 'id' => 5, 'match_time' => 1800 },
                                 { 'id' => 6, 'match_time' => 2400 }
                               ])
      end
    end
  end

  describe 'GET/{sport}/market/resolve_times' do
    it 'should get the all available market resolve times of the sport' do
      VCR.use_cassette('static_sport_event_enformation') do
        response = @client.market_resolve_times(sport: 'lol')
        expect(response).to eq([
                                 { 'id' => 1, 'match_time' => 600 },
                                 { 'id' => 2, 'match_time' => 900 },
                                 { 'id' => 3, 'match_time' => 1200 },
                                 { 'id' => 4, 'match_time' => 1500 }
                               ])
      end
    end
  end

  describe 'GET /{sport}/market/states' do
    it 'should get the all available market states of the sport' do
      VCR.use_cassette('static_sport_event_enformation') do
        response = @client.market_states(sport: 'lol')
        expect(response).to eq([
                                 { 'id' => 1, 'name' => 'closed', 'description' => nil },
                                 { 'id' => 2, 'name' => 'open', 'description' => nil },
                                 { 'id' => 3, 'name' => 'game_paused', 'description' => nil },
                                 { 'id' => 4, 'name' => 'canceled', 'description' => nil },
                                 { 'id' => 5, 'name' => 'suspended', 'description' => nil },
                                 { 'id' => 6, 'name' => 'bets_closed', 'description' => nil },
                                 { 'id' => 7, 'name' => 'ended', 'description' => nil }
                               ])
      end
    end
  end
end
