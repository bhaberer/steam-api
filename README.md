# SteamAPI

[![Gem Version](https://badge.fury.io/rb/steam-api.png)](http://badge.fury.io/rb/steam-api)
[![Dependency Status](https://gemnasium.com/bhaberer/steam-api.png)](https://gemnasium.com/bhaberer/steam-api)
[![Build Status](https://travis-ci.org/bhaberer/steam-api.png?branch=master)](https://travis-ci.org/bhaberer/steam-api)
[![Coverage Status](https://coveralls.io/repos/bhaberer/steam-api/badge.png?branch=master)](https://coveralls.io/r/bhaberer/steam-api?branch=master)
[![Code Climate](https://codeclimate.com/github/bhaberer/steam-api.png)](https://codeclimate.com/github/bhaberer/steam-api)

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

```2.1.1 :012 > Steam::User.vanity_to_steamid("asmeroth")
 => "76561197993276293"```

Examples: 

Get the Steam level for a user:



Get the Borderlands Achievements for a given player:

```2.1.1 :005 >   Steam::UserStats.player_achievements(8980, 76561197969622382)
 => {"steamID"=>"76561197969622382", "gameName"=>"Borderlands", "achievements"=>[{"apiname"=>"Achievement_1", "achieved"=>0}, {"apiname"=>"Achievement_2", "achieved"=>0}, {"apiname"=>"Achievement_3", "achieved"=>0}, {"apiname"=>"Achievement_4", "achieved"=>0}, {"apiname"=>"Achievement_5", "achieved"=>0}, {"apiname"=>"Achievement_6", "achieved"=>0}, {"apiname"=>"Achievement_7", "achieved"=>0}, {"apiname"=>"Achievement_8", "achieved"=>0}, {"apiname"=>"Achievement_9", "achieved"=>0}, {"apiname"=>"Achievement_10", "achieved"=>0}, {"apiname"=>"Achievement_11", "achieved"=>0}, {"apiname"=>"Achievement_12", "achieved"=>0}, {"apiname"=>"Achievement_13", "achieved"=>0}, {"apiname"=>"Achievement_14", "achieved"=>0}, {"apiname"=>"Achievement_15", "achieved"=>0}, {"apiname"=>"Achievement_16", "achieved"=>0}, {"apiname"=>"Achievement_17", "achieved"=>0}, {"apiname"=>"Achievement_18", "achieved"=>0}, {"apiname"=>"Achievement_19", "achieved"=>0}, {"apiname"=>"Achievement_20", "achieved"=>0}, {"apiname"=>"Achievement_21", "achieved"=>0}, {"apiname"=>"Achievement_22", "achieved"=>0}, {"apiname"=>"Achievement_23", "achieved"=>0}, {"apiname"=>"Achievement_24", "achieved"=>0}, {"apiname"=>"Achievement_25", "achieved"=>0}, {"apiname"=>"Achievement_26", "achieved"=>0}, {"apiname"=>"Achievement_27", "achieved"=>0}, {"apiname"=>"Achievement_28", "achieved"=>0}, {"apiname"=>"Achievement_29", "achieved"=>0}, {"apiname"=>"Achievement_30", "achieved"=>0}, {"apiname"=>"Achievement_31", "achieved"=>0}, {"apiname"=>"Achievement_32", "achieved"=>0}, {"apiname"=>"Achievement_33", "achieved"=>0}, {"apiname"=>"Achievement_34", "achieved"=>0}, {"apiname"=>"Achievement_35", "achieved"=>0}, {"apiname"=>"Achievement_36", "achieved"=>0}, {"apiname"=>"Achievement_37", "achieved"=>0}, {"apiname"=>"Achievement_38", "achieved"=>0}, {"apiname"=>"Achievement_39", "achieved"=>0}, {"apiname"=>"Achievement_40", "achieved"=>0}, {"apiname"=>"Achievement_41", "achieved"=>0}, {"apiname"=>"Achievement_42", "achieved"=>0}, {"apiname"=>"Achievement_43", "achieved"=>0}, {"apiname"=>"Achievement_44", "achieved"=>0}, {"apiname"=>"Achievement_45", "achieved"=>0}, {"apiname"=>"Achievement_46", "achieved"=>0}, {"apiname"=>"Achievement_47", "achieved"=>0}, {"apiname"=>"Achievement_48", "achieved"=>0}, {"apiname"=>"Achievement_49", "achieved"=>0}, {"apiname"=>"Achievement_50", "achieved"=>0}, {"apiname"=>"Achievement_51", "achieved"=>0}, {"apiname"=>"Achievement_52", "achieved"=>0}, {"apiname"=>"Achievement_53", "achieved"=>0}, {"apiname"=>"Achievement_54", "achieved"=>0}, {"apiname"=>"Achievement_55", "achieved"=>0}, {"apiname"=>"Achievement_56", "achieved"=>0}, {"apiname"=>"Achievement_57", "achieved"=>0}, {"apiname"=>"Achievement_58", "achieved"=>0}, {"apiname"=>"Achievement_59", "achieved"=>0}, {"apiname"=>"Achievement_60", "achieved"=>0}, {"apiname"=>"Achievement_61", "achieved"=>0}, {"apiname"=>"Achievement_62", "achieved"=>0}, {"apiname"=>"Achievement_63", "achieved"=>0}, {"apiname"=>"Achievement_64", "achieved"=>0}, {"apiname"=>"Achievement_65", "achieved"=>0}, {"apiname"=>"Achievement_66", "achieved"=>0}, {"apiname"=>"Achievement_67", "achieved"=>0}, {"apiname"=>"Achievement_68", "achieved"=>0}, {"apiname"=>"Achievement_69", "achieved"=>0}, {"apiname"=>"Achievement_70", "achieved"=>0}, {"apiname"=>"Achievement_71", "achieved"=>0}, {"apiname"=>"Achievement_72", "achieved"=>0}, {"apiname"=>"Achievement_73", "achieved"=>0}, {"apiname"=>"Achievement_74", "achieved"=>0}, {"apiname"=>"Achievement_75", "achieved"=>0}, {"apiname"=>"Achievement_76", "achieved"=>0}, {"apiname"=>"Achievement_79", "achieved"=>0}, {"apiname"=>"Achievement_77", "achieved"=>0}, {"apiname"=>"Achievement_78", "achieved"=>0}, {"apiname"=>"Achievement_80", "achieved"=>0}]}```
 

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
