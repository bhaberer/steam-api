# -*- encoding: utf-8 -*-
require 'faraday'
require 'json'

require_relative 'steam-api/version'
require_relative 'steam-api/steam'
require_relative 'steam-api/client'
require_relative 'steam-api/exceptions'
require_relative 'steam-api/response'
require_relative 'steam-api/helpers'
require_relative 'steam-api/steam/apps'
require_relative 'steam-api/steam/economy'
require_relative 'steam-api/steam/news'
require_relative 'steam-api/steam/player'
require_relative 'steam-api/steam/remote_storage'
require_relative 'steam-api/steam/store'
require_relative 'steam-api/steam/user'
require_relative 'steam-api/steam/user_stats'

include Steam::Helpers
