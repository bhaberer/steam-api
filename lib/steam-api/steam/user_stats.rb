# -*- encoding: utf-8 -*-
module Steam
  # A Ruby DSL for communicating with the Steam Web API.
  # @see https://developer.valvesoftware.com/wiki/Steam_Web_API
  # @since 1.0.0
  module UserStats
    # Get Global Achievement Percentages for App
    # @param [Fixnum] :appid The ID of the game to retrieve achievement percentages
    #   for. This can be the ID of any Steamworks game with achievements available.
    # @return [Hash] The hash object of information on the global achievements overview of
    #   a specific game in percentages.
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetGlobalAchievementPercentagesForApp
    def self.achievement_percentages(appid)
      response = build_client.get 'GetGlobalAchievementPercentagesForApp/v2',
                                  params: { gameid: appid }
      response = JSON.parse response.body
      response = parse_key(response, 'achievementpercentages')
      response = parse_key(response, 'achievements')
      response
    end

    # Get Global Stats for Game
    # @param [Hash] params Parameters to pass to the API
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
    def self.global_game(appid, params: {})
      response = build_client.get 'GetGlobalStatsForGame/v1',
                                  params: params
      JSON.parse response.body
    end

    # Get Number of Current Players
    # @param [Hash] params Parameters to pass to the API
    # @option params [Fixnum] :appid AppID that we're getting user count for
    # @return [Hash] A hash containing the API response
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetNumberOfCurrentPlayers
    def self.player_count(appid)
      response = build_client.get 'GetNumberOfCurrentPlayers/v1',
                                  params: { appid: appid }
      response = JSON.parse response.body
      response = parse_key(response, 'response')
      response = parse_key(response, 'player_count')
      response
    end

    # Get Player Achievements
    # @param [Hash] params Parameters to pass to the API
    # @option params [Fixnum] :steamid 64 bit Steam ID to return Achievements list for.
    # @option params [Fixnum] :appid AppID to get achievements for
    # @option params [String] :language Language. If specified, it will return language data for
    #   the requested language. (Optional)
    # @return [Hash] A hash containing the API response
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetPlayerAchievements
    def self.player_achievements(params: {})
      response = build_client.get 'GetPlayerAchievements/v1',
                                  params: params
      JSON.parse response
    end

    private

    def self.build_client
      Steam::Client.new('http://api.steampowered.com/ISteamUserStats')
    end

    def self.parse_key(response, key)
      fail Steam::JSONError unless response.key?(key)
      response[key]
    end
  end
end
