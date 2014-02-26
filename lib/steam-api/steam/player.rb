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
      response = client.get 'GetOwnedGames/v1',
                                  params: params
      response
    end

    # Get Recently Played Games
    # @param [Hash] params Parameters to pass to the API
    # @option params [String] :steamid The SteamID of the account.
    # @option params [String] :count Optionally limit to a certain number of games (the number of
    #   games a person has played in the last 2 weeks is typically very small)
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetRecentlyPlayedGames
    def self.recently_played_games(steamid, params: {})
      response = client.get 'GetRecentlyPlayedGames/v1',
                                  params: params
      response
    end

    # Get a player's Steam Level
    # @param [Fixnum] steamid The SteamID of the account.
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetSteamLevel
    def self.steam_level(steamid)
      response = client.get 'GetSteamLevel/v1',
                            params: { steamid: steamid }
      response
    end

    # Get a player's Steam Level
    # @param [Fixnum] steamid The SteamID of the account.
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetBadges
    def self.badges(steamid)
      response = client.get 'GetBadges/v1',
                            params: { steamid: steamid }
      response
    end

    # Get a player's Steam Level
    # @param [Fixnum] steamid The SteamID of the account.
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetCommunityBadgeProgress
    def self.community_badge_progress(steamid)
      response = client.get 'GetCommunityBadgeProgress/v1',
                            params: { steamid: steamid }
      response
    end

    private

    def self.client
      build_client 'IPlayerService'
    end
  end
end
