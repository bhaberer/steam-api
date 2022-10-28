# frozen_string_literal: true

module Steam
  # A Ruby DSL for communicating with the Steam::User Web API.
  # @see https://developer.valvesoftware.com/wiki/Steam_Web_API
  # @since 1.0.0
  module User
    # Get User's Friend List
    # @param [String] steamid
    # @param [String] relationship Relationship filter.
    #   Possibles values: all, friend.
    # @return [Hash] A hash object resulting from the API call; should
    #   returns the friend list of any Steam user, provided their Steam
    #   Community profile visibility is set to "Public".
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetFriendList
    def self.friends(steamid, relationship: :all)
      response = client.get 'GetFriendList/v1/',
                            params: { steamid: steamid,
                                      relationship: relationship }
      response = response.parse_key('friendslist')
                         .parse_key('friends')
      response
    end

    # Get Multiple Player Bans
    # @param [Array] steamids Array of SteamIDs
    # @return [Hash] A hash containing the API response
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetPlayerBans
    def self.bans(steamids)
      steamids = [steamids] unless steamids.is_a?(Array)
      response = client.get 'GetPlayerBans/v1/',
                            params: { steamids: steamids.join(',') }
      response
    end

    # Get Player Summaries
    # @option params [Array] :steamids List of player's steamids
    # @return [Hash] The hash object resulting from the API call. Some data
    #   associated with a Steam account may be hidden if the user has their
    #   profile visibility set to "Friends Only" or "Private". In that case,
    #   only public data will be returned.
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetPlayerSummaries
    def self.summary(steamid)
      summaries([steamid]).first
    end

    # Get Player Summaries
    # @param [Array] steamids List of player's steamids
    # @return [Hash] The hash object resulting from the API call. Some data
    #   associated with a Steam account may be hidden if the user has their
    #   profile visibility set to "Friends Only" or "Private". In that case,
    #   only public data will be returned.
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetPlayerSummaries
    def self.summaries(steamids)
      response = client.get 'GetPlayerSummaries/v2/',
                            params: { steamids: steamids.join(',') }
      response.parse_key('response')
              .parse_key('players')
    end

    # Get User Groups
    # @param [Fixnum] steamid 64bit Steam ID to return friend list.
    # @return [Hash] A hash containing the API response
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetUserGroupList
    def self.groups(steamid)
      response = client.get 'GetUserGroupList/v1', params: { steamid: steamid }
      response = response.parse_key('response')
      response.check_success
      response.parse_key('groups')
    end

    # Resolve Vanity URL
    # @param [String] vanityurl The vanity URL part of a user's Steam
    #   profile URL. This is the basename of http://steamcommunity.com/id/ URLs
    # @return [Hash] A hash containing the API response
    # @see http://wiki.teamfortress.com/wiki/WebAPI/ResolveVanityURL
    def self.vanity_to_steamid(vanityurl)
      response = client.get 'ResolveVanityURL/v1',
                            params: { vanityurl: vanityurl }
      response = response.parse_key('response')
      response.check_success(success_condition: 1)
      response.parse_key('steamid')
    end

    def self.client
      build_client 'ISteamUser'
    end
  end
end
