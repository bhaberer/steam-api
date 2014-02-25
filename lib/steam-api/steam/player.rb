# -*- encoding: utf-8 -*-
module Steam
  # A Ruby DSL for communicating with the Steam Web API.
  # @see https://developer.valvesoftware.com/wiki/Steam_Web_API
  # @since 1.0.0
  module Player
    # Get Owned Games
    # @param [Hash] params Parameters to pass to the API
    # @option params [Fixnum] :steamid The 64 bit ID of the player. (Optional)
    # @option params [Boolean] :include_appinfo (false) Whether or not to include additional
    #   details of apps - name and images.
    # @option params [Boolean] :include_played_free_games (false) Whether or not to list
    #   free-to-play games in the results.
    # @option params [Array] :appids_filter You can optionally filter the list to a set of appids.
    #   Note that these cannot be passed as a URL parameter, instead you must use the JSON format
    #   described in Steam_Web_API#Calling_Service_interfaces. The expected input is an array of
    #   integers (in JSON: "appids_filter: [ 440, 500, 550 ]" )
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetOwnedGames
    def self.owned_games(params: {})
      response = build_client.get 'IPlayerService/GetOwnedGames/v1',
                                  params: params
      JSON.parse response
    end

    # Get Recently Played Games
    # @param [Hash] params Parameters to pass to the API
    # @option params [String] :steamid The SteamID of the account.
    # @option params [String] :count Optionally limit to a certain number of games (the number of
    #   games a person has played in the last 2 weeks is typically very small)
    # @param [String] apikey Steam Api Key
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetRecentlyPlayedGames
    def self.recently_played_games(steamid, params: {})
      response = build_client.get 'GetRecentlyPlayedGames/v1',
                                  params: params
      JSON.parse response
    end

    private

    def self.build_client
      Steam::Client.new('http://api.steampowered.com')
    end

    def self.parse_response(response)
      response = JSON.parse(response.body)
      fail Steam::JSONError unless response.key?('appnews') &&
                                   response['appnews'].key?('newsitems')
      response = response['appnews']['newsitems']
      response
    rescue JSON::ParserError
      { error: '500 Internal Server Error' }
    end
  end
end
