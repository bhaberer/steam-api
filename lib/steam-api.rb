require 'steam-api/version'
require 'patron'

# A Ruby DSL for communicating with the Steam Web API.
# @see https://developer.valvesoftware.com/wiki/Steam_Web_API
# @since 1.0.0
module Steam

  # The Patron object used to access the REST endpoint for the Steam API.
  TARGET = Patron::Session.new

  module Apps
    TARGET.base_url = 'http://api.steampowered.com/ISteamApps/'

    # Get Steam Applications
    # @return [Hash] A list of objects containing the title and app ID of each program
    #   available in the store.
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetAppList
    def Apps.get_all
      TARGET.get([:GetAppList, :v2].join('/')).parse_json
    end

    # Get Servers at Address
    # @param [Hash] params Parameters to pass to the API
    # @option params [String] :addr IP or IP:queryport to list
    # @return [Hash] A hash containing the API response
    def Apps.get_servers(params = {})
      TARGET.get([:GetServersAtAddress, :v1, params.to_params].join('/')).parse_json
    end

    # Check if a given version of an App is current
    # @param [Hash] params Parameters to pass to the API
    # @option params [Fixnum] appid AppID of game
    # @option params [Fixnum] version The installed version of the game
    # @return [Hash] A hash containing the API response
    # @see http://wiki.teamfortress.com/wiki/WebAPI/UpToDateCheck
    def Apps.up_to_date(params = {})
      TARGET.get([:UpToDateCheck, :v1, params.to_params].join('/')).parse_json
    end
  end

  module Economy
    TARGET.base_url = 'http://api.steampowered.com/ISteamEconomy/'

    # Get Asset Class Info
    # @param [Hash] params Parameters to pass to the API
    # @option params [String] :key Steam Api Key
    # @option params [String] :appid The application ID for the Steam Game.
    # @option params [Fixnum] :class_count The number of classids passed to the request.
    # @option params [Fixnum] :classidN Where N can be a series of sequential numbers to form a list of class IDs. [1] [2]
    # @option params [Fixnum] :instanceidN Instance ID of the nth class. (Optional)
    # @option params [String] :language The ISO639-1 language code for the language all localized
    #   strings should be returned in. Not all strings have been translated to every language.
    #   If a language does not have a string, the English string will be returned instead. If this
    #   parameter is omitted the string token will be returned for the strings. (Optional)
    # @return [Hash] A hash containing the API response
    # @see http://wiki.teamfortress.com/wiki/WebAPI/UpToDateCheck
    def Economy.asset_info(params = {})
      TARGET.get([:GetAssetClassInfo, :v0001, params.to_params].join('/')).parse_json
    end

    # Get Asset Prices
    # @param [Hash] params Parameters to pass to the API
    # @option params [String] :key Steam Api Key
    # @option params [String] :appid The application ID for the Steam Game.
    # @option params [String] :language The ISO639-1 language code for the language all localized
    #   strings should be returned in. Not all strings have been translated to every language.
    #   If a language does not have a string, the English string will be returned instead. If this
    #   parameter is omitted the string token will be returned for the strings. (Optional)
    # @option params [String] :currency The ISO 4217 code for currency specific filtering. (Optional)
    # @return [Hash] A hash containing the API response
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetAssetPrices
    def Economy.asset_prices(params)
      TARGET.get([:GetAssetPrices, :v0001, params.to_params].join('/')).parse_json
    end
  end

  module News
    TARGET.base_url = 'http://api.steampowered.com/ISteamNews/'

    # Get News for App
    # @param [Hash] params Parameters to pass to the API
    # @option params [String] :appid The application ID for the Steam Game.
    # @option params [String] :key Steam Api Key
    # @option params [Fixnum] :count How many news enties you want to get returned. (Optional)
    # @option params [Fixnum] :maxlength Maximum length of each news entry. (Optional)
    # @option params [Fixnum] :enddate Unix timestamp, returns posts before this date. (Optional)
    # @option params [String] :feeds Commma-seperated list of feed names to return news for. (Optional)
    # @return [Hash] A hash object of the latest news items for a game specified by its appID.
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetNewsForApp
    def News.get(appid, params = {})
      TARGET.get([:GetNewsForApp, :v0002, params.to_params].join('/')).parse_json
    end
  end

  module Player
    # Get Owned Games
    # @param [Hash] params Parameters to pass to the API
    # @option params [String] :key Steam Api Key
    # @option params [Fixnum] :steamid The 64 bit ID of the player. (Optional)
    # @option params [Boolean] :include_appinfo (false) Whether or not to include additional
    #   details of apps - name and images.
    # @option params [Boolean] :include_played_free_games (false) Whether or not to list
    #   free-to-play games in the results.
    # @option params [Array] appids_filter You can optionally filter the list to a set of appids.
    #   Note that these cannot be passed as a URL parameter, instead you must use the JSON format
    #   described in Steam_Web_API#Calling_Service_interfaces. The expected input is an array of
    #   integers (in JSON: "appids_filter: [ 440, 500, 550 ]" )
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetOwnedGames
    def Steam.get_owned_games(params = {})
      TARGET.get([:IPlayerService, :GetOwnedGames, :v1, params.to_params].join('/')).parse_json
    end

    # Get Recently Played Games
    # @param [Hash] params Parameters to pass to the API
    # @option params [String] :key Steam Api Key
    # @option params [String] :steamid The SteamID of the account.
    # @option params [String] :count Optionally limit to a certain number of games (the number of
    #   games a person has played in the last 2 weeks is typically very small)
    # @param [String] apikey Steam Api Key
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetRecentlyPlayedGames
    def Steam.get_recently_played_games(params = {})
      TARGET.get([:GetRecentlyPlayedGames, :v1, options.to_params].join('/')).parse_json
    end
  end

  module RemoteStorage
    TARGET.base_url = 'http://api.steampowered.com/ISteamRemoteStorage/'

    # Get Published File Details
    # @param [Hash] params Parameters to pass to the API
    # @option params [String] :key Steam Api Key
    # @option params [Fixnum] :itemcount Number of items being requested
    # @option params [Fixnum] :publishedfileids Published file id to look up
    # @return [Hash] A hash containing the API response
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetPublishedFileDetails
    def RemoteStorage.get_published_file(params = {})
      TARGET.get([:GetPublishedFileDetails, :v1, options.to_params].join('/')).parse_json
    end

    # Get UGC File Details
    # @param [Hash] params Parameters to pass to the API
    # @option params [String] :key Steam Api Key
    # @option params [Fixnum] :steamid If specified, only returns details if the
    #   file is owned by the SteamID specified
    # @option params [Fixnum] :ugcid ID of UGC file to get info for
    # @option params [Fixnum] :appid appID of product
    # @return [Hash] A hash containing the API response
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetUGCFileDetails
    def RemoteStorage.get_ugc_file(params = {})
      TARGET.get([:GetUGCFileDetails, :v1, options.to_params].join('/')).parse_json
    end
  end

  module User
    TARGET.base_url = 'http://api.steampowered.com/ISteamUser/'

    # Get Friend List
    # @param [Hash] params Parameters to pass to the API
    # @option params [Fixnum] :steamid 64 bit Steam ID to return friend list for.
    # @option params [String] :relationship Relationship filter. Possibles values: all, friend.
    # @option params [String] :key Steam Api Key
    # @return [Hash] A hash object resulting from the API call; should returns the friend list of
    #   any Steam user, provided their Steam Community profile visibility is set to "Public".
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetFriendList
    def User.get_friends(params = {})
      TARGET.get([:GetFriendList, :v1, params.to_params].join('/')).parse_json
    end

    # Get Player Bans
    # @param [Hash] params Parameters to pass to the API
    # @option params [String] :key Steam Api Key
    # @option params [String] :steamids Comma-delimited list of SteamIDs
    # @return [Hash] A hash containing the API response
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetPlayerBans
    def User.get_bans(params = {})
      TARGET.get([:GetPlayerBans, :v1, params.to_params].join('/')).parse_json
    end

    # Get Player Summaries
    # @param [Hash] params Parameters to pass to the API
    # @option params [String] :apikey Steam Api Key
    # @option params [Array] :steamids List of player's steamids
    # @return [Hash] The hash object resulting from the API call. Some data associated with a
    #   Steam account may be hidden if the user has their profile visibility set to "Friends Only"
    #   or "Private". In that case, only public data will be returned.
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetPlayerSummaries
    def User.get_summaries(params = {})
      TARGET.get([:GetPlayerSummaries, :v2, .sramsto_params].join('/')).parse_json
    end

    # Get User Groups
    # @param [Hash] params Parameters to pass to the API
    # @option params [Fixnum] :steamid 64 bit Steam ID to return friend list for.
    # @option params [String] :key Steam Api Key
    # @return [Hash] A hash containing the API response
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetUserGroupList
    def User.get_groups(params = {})
      TARGET.get([:GetUserGroupList, :v1, options.to_params].join('/')).parse_json
    end

    # Resolve Vanity URL
    # @param [Hash] params Parameters to pass to the API
    # @option params [String] :vanityurl The vanity URL part of a user's Steam profile URL. This
    #   is the basename of http://steamcommunity.com/id/ URLs.
    # @option params [String] :key Steam Api Key
    # @return [Hash] A hash containing the API response
    # @see http://wiki.teamfortress.com/wiki/WebAPI/ResolveVanityURL
    def User.resolve_vanity_url(params = {})
      TARGET.get([:ResolveVanityURL, :v0001, options.to_params].join('/')).parse_json
    end
  end

  module UserStats
    TARGET.base_url = 'http://api.steampowered.com/ISteamUserStats/'

    # Get Global Achievement Percentages for App
    # @param [Hash] params Parameters to pass to the API
    # @option params [Fixnum] :gameid The ID of the game to retrieve achievement percentages
    #   for. This can be the ID of any Steamworks game with achievements available.
    # @option params [String] :key Steam Api Key
    # @return [Hash] The hash object of information on the global achievements overview of
    #   a specific game in percentages.
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetGlobalAchievementPercentagesForApp
    def UserStats.achievement_percentages(options)
      TARGET.get([:GetGlobalAchievementPercentagesForApp, :v0002, params.to_params].join('/')).parse_json
    end

    # Get Global Stats for Game
    # @param [Hash] params Parameters to pass to the API
    # @option params [String] :key Steam Api Key
    # @option params [String] :appid The application ID for the Steam Game.
    # @option params [Fixnum] :count Number of stats to get data for.
    # @option params [String] :name[0] Names of the stats to get. For more than one value, use
    #   a parameter for each request. (name[0], name[1], ...) Not all stats are globally
    #   aggregated. The developer of the game must mark the stat as globally aggregated.
    # @option params [String] :startdate Start date for daily totals
    #   (unix epoch timestamp). (Optional)
    # @option params [String] :enddate End date for daily totals (unix epoch timestamp). (Optional)
    # @return [Hash] A hash containing the API response
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetGlobalStatsForGame
    def UserStats.global_game(params = {})
      TARGET.get([:GetGlobalStatsForGame, :v0001, params.to_params].join('/')).parse_json
    end

    # Get Number of Current Players
    # @param [Hash] params Parameters to pass to the API
    # @option params [String] :key Steam Api Key
    # @option params [Fixnum] :appid AppID that we're getting user count for
    # @return [Hash] A hash containing the API response
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetNumberOfCurrentPlayers
    def UserStats.current_player_count(params = {})
      TARGET.get([:GetNumberOfCurrentPlayers, :v1, params.to_params].join('/')).parse_json
    end

    # Get Player Achievements
    # @param [Hash] params Parameters to pass to the API
    # @option params [String] :key Steam Api Key
    # @option params [Fixnum] :steamid 64 bit Steam ID to return Achievements list for.
    # @option params [Fixnum] :appid AppID to get achievements for
    # @option params [String] :language Language. If specified, it will return language data for
    #   the requested language. (Optional)
    # @return [Hash] A hash containing the API response
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetPlayerAchievements
    def Steam.get_player_achievements(params = {})
      TARGET.get([:GetPlayerAchievements, :v0001, options.to_params].join('/')).parse_json
    end

    :q


  end


  private

  # Takes a hash and converts it into a URL encoded parameter string.
  #   NOTE: this does not do any uri escaping at this point, since all args should be numeric.
  # @param [Hash] params Hash of params you want broken up into a query string,
  #   escaped, and returned to you.
  # @return [String] Escaped parameter string to append to a url.
  class Hash
    def to_params(params = {})
      params[:format] = :json
      return "?#{params.each.map{ |x| x.join('=') }.join('&')}"
    end
  end
end

module Patron
  # Parse the JSON response of the Response's body into a standard ruby object.
  # @return [Hash,String] The parsed body of the Response Object, or an Error.
  def parse_json
    body = self.body
    begin
      JSON.parse(body)
    rescue JSON::ParserError
      return { :error => 'Problem Parsing the JSON Response from the API', :body => body }
    end
  end
end
