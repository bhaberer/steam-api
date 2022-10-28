# frozen_string_literal: true

module Steam
  # A Ruby DSL for communicating with the Steam Web API.
  # @see https://developer.valvesoftware.com/wiki/Steam_Web_API
  # @since 1.0.0
  module UserStats
    class << self
      # Get Global Achievement Percentages for App
      # @param [Fixnum] appid The ID of the game or application
      # @return [Hash] The hash object of information on the global achievements
      #   overview of a specific game in percentages.
      # @see http://wiki.teamfortress.com/wiki/WebAPI/GetGlobalAchievementPercentagesForApp
      def achievement_percentages(appid)
        response = client.get 'GetGlobalAchievementPercentagesForApp/v2', params: { gameid: appid }
        response.parse_key('achievementpercentages').parse_key('achievements')
      end

      # Get Global Stats for Game
      # @param [Fixnum] appid The ID of the game or application
      # @param [Hash] params Parameters to pass to the API
      # @option params [Fixnum] :count Number of stats to get data for.
      # @option params [String] :name[0] Names of the stats to get. For more than
      #   one value, use a parameter for each request. (name[0], name[1], ...)
      #   Not all stats are globally aggregated. The developer of the game must
      #   mark the stat as globally aggregated.
      # @option params [String] :startdate Start date for daily totals
      #   (unix epoch timestamp). (Optional)
      # @option params [String] :enddate End date for daily totals (unix epoch
      #    timestamp). (Optional)
      # @return [Hash] A hash containing the API response
      # @see http://wiki.teamfortress.com/wiki/WebAPI/GetGlobalStatsForGame
      def global_for_game(appid, params: {})
        params[:appid] = appid
        response = client.get 'GetGlobalStatsForGame/v1', params: params
        response.parse_key('response')
      end

      # Get stat schema
      # @param [Fixnum] appid The application ID for the Steam Game.
      # @param [String] language (Optional) Language
      # @return [Hash] A hash containing the API response
      # @see http://wiki.teamfortress.com/wiki/WebAPI/GetSchemaForGame
      def game_schema(appid, language: nil)
        params = { appid: appid }
        params[:l] = language unless language.nil?
        response = client.get 'GetSchemaForGame/v2', params: params
        response.parse_key('game')
      end

      # Get Number of Current Players
      # @param [Fixnum] appid to pass to the API
      # @return [Hash] A hash containing the API response
      # @see http://wiki.teamfortress.com/wiki/WebAPI/GetNumberOfCurrentPlayers
      def player_count(appid)
        response = client.get 'GetNumberOfCurrentPlayers/v1', params: { appid: appid }
        response.parse_key('response').parse_key('player_count')
      end

      # Get Player Achievements
      # @param [Fixnum] steamid 64 bit Steam ID to return Achievements list for.
      # @param [Fixnum] appid AppID to get achievements for
      # @param [String] language Language. If specified, it will return language
      #   data for the requested language. (Optional)
      # @return [Hash] A hash containing the API response
      # @see http://wiki.teamfortress.com/wiki/WebAPI/GetPlayerAchievements
      def player_achievements(appid, steamid, language: nil)
        params = { appid: appid, steamid: steamid }
        params[:l] = language unless language.nil?
        response = client.get 'GetPlayerAchievements/v1', params: params
        response = response.parse_key('playerstats')
        response.check_success
        response.delete('success')
        response
      end

      # Get User Stats for Game
      # @param [Fixnum] appid AppID to get stats for.
      # @param [Fixnum] steamid 64 bit Steam ID to return stats for.
      # @return [Hash] A hash containing the API response.
      # @see https://developer.valvesoftware.com/wiki/Steam_Web_API#GetUserStatsForGame_.28v0002.29
      def player_stats(appid, steamid)
        response = client.get 'GetUserStatsForGame/v2', params: { appid: appid, steamid: steamid }
        response.parse_key('playerstats')
      end

      def client
        build_client('ISteamUserStats')
      end
    end
  end
end
