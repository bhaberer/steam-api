module Steam
  # A Ruby DSL for communicating with the Steam::User Web API.
  # @see https://developer.valvesoftware.com/wiki/Steam_Web_API
  # @since 1.0.0
  module User
    # Get User's Friend List
    # @param [Hash] params Parameters to pass to the API
    # @param [String] :relationship Relationship filter.
    #   Possibles values: all, friend.
    # @return [Hash] A hash object resulting from the API call; should
    #   returns the friend list of any Steam user, provided their Steam
    #   Community profile visibility is set to "Public".
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetFriendList
    def self.friends(steamid, relationship: :all)
      response =
        build_client.get 'GetFriendList/v1/',
                         params: { steamid: steamid,
                                   relationship: relationship }
      response = JSON.parse(response.body)
      fail Steam::JSONError unless response.key?('friendslist')
      return {} unless response['friendslist'].key?('friends')
      response['friendslist']['friends']
    rescue JSON::ParserError
      { error: '500 Internal Server Error' }
    end

    # Get Multiple Player Bans
    # @param [Array] :steamids Array of SteamIDs
    # @return [Hash] A hash containing the API response
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetPlayerBans
    def self.bans(steamids)
      steamids = [steamids] unless steamids.is_a?(Array)
      response =
        build_client.get 'GetPlayerBans/v1/',
                         params: { steamids: steamids.join(',') }
      JSON.parse response.body
    rescue JSON::ParserError
      { error: '500 Internal Server Error' }
    end

    # Get Player Summaries
    # @option params [Array] :steamids List of player's steamids
    # @return [Hash] The hash object resulting from the API call. Some data
    #   associated with a Steam account may be hidden if the user has their
    #   profile visibility set to "Friends Only" or "Private". In that case,
    #   only public data will be returned.
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetPlayerSummaries
    def self.summary(steamid)
      Steam::User.summaries([steamid]).first
    end

    # Get Player Summaries
    # @param [String] :steamids List of player's steamids
    # @param [Array] :steamids List of player's steamids
    # @return [Hash] The hash object resulting from the API call. Some data
    #   associated with a Steam account may be hidden if the user has their
    #   profile visibility set to "Friends Only" or "Private". In that case,
    #   only public data will be returned.
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetPlayerSummaries
    def self.summaries(steamids)
      response = build_client.get 'GetPlayerSummaries/v2/',
                                  params: { steamids: steamids.join(',') }
      JSON.parse(response.body)['response']['players']
    rescue JSON::ParserError
      { error: '500 Internal Server Error' }
    end

    # Get User Groups
    # @param [Hash] params Parameters to pass to the API
    # @option params [Fixnum] :steamid 64 bit Steam ID to return friend list.
    # @option params [String] :key Steam Api Key
    # @return [Hash] A hash containing the API response
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetUserGroupList
    def self.groups(steamid)
      response =
        build_client.get 'GetUserGroupList/v1', params: { steamid: steamid }
      response = JSON.parse(response.body)
      fail Steam::JSONError unless response.key?('response')
      response = response['response']
      fail Steam::JSONError unless response.key?('success') &&
                                   response.key?('groups')
      fail Steam::SteamError unless response['success']
      response['groups']
    rescue JSON::ParserError
      { error: '500 Internal Server Error' }
    end

    # Resolve Vanity URL
    # @param [Hash] params Parameters to pass to the API
    # @option params [String] :vanityurl The vanity URL part of a user's Steam
    #   profile URL. This is the basename of http://steamcommunity.com/id/ URLs
    # @option params [String] :key Steam Api Key
    # @return [Hash] A hash containing the API response
    # @see http://wiki.teamfortress.com/wiki/WebAPI/ResolveVanityURL
    def self.vanity_to_steamid(vanityurl)
      response = build_client.get 'ResolveVanityURL/v1',
                                  params: { vanityurl: vanityurl }
      response = JSON.parse response.body
      fail Steam::JSONError unless response.key?('response')
      response = response['response']
      fail Steam::JSONError unless response.key?('success') &&
                                   response.key?('steamid')
      fail Steam::SteamError unless response['success']
      response['steamid']
    rescue JSON::ParserError
      { error: '500 Internal Server Error' }
    end

    private

    def self.build_client
      Steam::Client.new('http://api.steampowered.com/ISteamUser')
    end
  end
end
