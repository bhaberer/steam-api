# A Ruby DSL for communicating with the Steam Web API.
# @see https://developer.valvesoftware.com/wiki/Steam_Web_API
# @since 1.0.0
module Steam
  module UserStats
    # The Patron object used to access the REST endpoint for the Steam API.
    TARGET = Patron::Session.new

    TARGET.base_url = 'http://api.steampowered.com/ISteamUserStats/'

    # Get Global Achievement Percentages for App
    # @param [Hash] params Parameters to pass to the API
    # @option params [Fixnum] :gameid The ID of the game to retrieve achievement percentages
    #   for. This can be the ID of any Steamworks game with achievements available.
    # @option params [String] :key Steam Api Key
    # @return [Hash] The hash object of information on the global achievements overview of
    #   a specific game in percentages.
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetGlobalAchievementPercentagesForApp
    def UserStats.achievement_percentages(params = {})
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
      TARGET.get([:GetPlayerAchievements, :v0001, params.to_params].join('/')).parse_json
    end
  end
end
