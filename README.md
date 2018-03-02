# SteamAPI

[![Gem Version](https://badge.fury.io/rb/steam-api.png)](http://badge.fury.io/rb/steam-api)
[![Dependency Status](https://gemnasium.com/bhaberer/steam-api.png)](https://gemnasium.com/bhaberer/steam-api)
[![Build Status](https://travis-ci.org/bhaberer/steam-api.png?branch=master)](https://travis-ci.org/bhaberer/steam-api)
[![Maintainability](https://api.codeclimate.com/v1/badges/e3100c4ed420e839a6cc/maintainability)](https://codeclimate.com/github/bhaberer/steam-api/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/e3100c4ed420e839a6cc/test_coverage)](https://codeclimate.com/github/bhaberer/steam-api/test_coverage)

`steam-api` is a simple gem to expose the Steam WebApi directly.

The Gem is not quite finished, but once it is, I will note that here, I still have a lot of work to do (especially on the docs).

## Installation

Add this line to your application's Gemfile:

    gem 'steam-api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install steam-api

## Usage

First you will need to set your Steam API Key you can get this at http://steamcommunity.com/dev/apikey

Once you get it, go ahead and set it. (You can also pass it as the `STEAM_API_KEY` env variable)

```2.1.1 :001 > Steam.apikey = 'YOURAPIKEY'```

Once you've done that you can use any of the API functions in the various modules, for a list of all available commands please  see the docs here: http://rubydoc.info/gems/steam-api/ Of note, all the commands use the numerical Steam ID, if you need to convert from the vanity name you can use the following method:

```
2.1.1 :012 > Steam::User.vanity_to_steamid("asmeroth")

 => "76561197993276293"
```

### Examples

Get the Steam level for a user:

```
2.1.1 :014 > Steam::Player.steam_level(76561197993276293)

 => 34
```

Get the Borderlands Achievements for a given player:

```
2.1.1 :005 >   Steam::UserStats.player_achievements(8980, 76561197969622382)

 => {"steamID"=>"76561197969622382", "gameName"=>"Borderlands", "achievements"=>[{"apiname"=>"Achievement_1", "achieved"=>0}, {"apiname"=>"Achievement_2", "achieved"=>0}, {"apiname"=>"Achievement_3", "achieved"=>0}, {"apiname"=>"Achievement_4", "achieved"=>0}, {"apiname"=>"Achievement_5", "achieved"=>0}, {"apiname"=>"Achievement_6", "achieved"=>0}, {"apiname"=>"Achievement_7", "achieved"=>0}, {"apiname"=>"Achievement_8", "achieved"=>0}, {"apiname"=>"Achievement_9", "achieved"=>0}, {"apiname"=>"Achievement_10", ... ]}
```
 

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
