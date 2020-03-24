# RTS Ruby Wrapper


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rts'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rts

## Usage

To create RTS:Client
client = RTS:Client.new(api_key: 'pass_api_key', client_certificate: 'pass_ssl_certificate', client_key: 'pass_ssl_key')

#### sports
client.sports

#### leagues
client.league(sport: 'lol')

#### teams
client.teams(sport: 'lol')

#### players
 client.players(sport: 'lol')

###### players by team_id
 client.players(sport: 'lol', team_id: 1)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rmishra-ror/rts.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
