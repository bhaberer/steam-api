# A Ruby DSL for communicating with the Steam Web API.
# @see https://developer.valvesoftware.com/wiki/Steam_Web_API
# @since 1.0.0
module Steam
  module Player
    # The Patron object used to access the REST endpoint for the Steam API.
    TARGET = Patron::Session.new

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
end
