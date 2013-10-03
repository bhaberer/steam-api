require 'faraday'
require 'json'
# A Ruby DSL for communicating with the Steami Web API.
# @see https://developer.valvesoftware.com/wiki/Steam_Web_API
# @since 1.0.0
module Steam
  class User
    TARGET = Faraday.new(:url => 'http://api.steampowered.com/ISteamUser')
    attr_accessor :id, :apikey

    def initialize(steamid: steamid)
      @id = steamid
      @apikey = Steam.apikey
    end
















    # Get Friend List
    # @param [Hash] params Parameters to pass to the API
    # @option params [String] :relationship Relationship filter. Possibles values: all, friend.
    # @return [Hash] A hash object resulting from the API call; should returns the friend list of
    #   any Steam user, provided their Steam Community profile visibility is set to "Public".
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetFriendList
    def friends(relationship = :all)
      puts '###########'
      params = { steamid: @id, relationship: relationship, key: @apikey }
      puts '###########' + params
      response = TARGET.get 'GetFriendList/v0001/', params
      # JSON.parse(response.body)
      puts '###########' + params
    end

    # Get Player Bans
    # @param [Hash] params Parameters to pass to the API
    # @option params [String] :key Steam Api Key
    # @option params [String] :steamids Comma-delimited list of SteamIDs
    # @return [Hash] A hash containing the API response
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetPlayerBans
    def bans(params = {})
      TARGET.get([:GetPlayerBans, :v1, params.to_params].join('/')).parse_json
    end

    def self.bans(steamids: steamids)

    end
=begin
    # Get Player Summaries
    # @param [Hash] params Parameters to pass to the API
    # @option params [String] :apikey Steam Api Key
    # @option params [Array] :steamids List of player's steamids
    # @return [Hash] The hash object resulting from the API call. Some data associated with a
    #   Steam account may be hidden if the user has their profile visibility set to "Friends Only"
    #   or "Private". In that case, only public data will be returned.
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetPlayerSummaries
    def User.get_summaries(params = {})
      TARGET.get([:GetPlayerSummaries, :v2, params.to_params].join('/')).parse_json
    end

    # Get User Groups
    # @param [Hash] params Parameters to pass to the API
    # @option params [Fixnum] :steamid 64 bit Steam ID to return friend list for.
    # @option params [String] :key Steam Api Key
    # @return [Hash] A hash containing the API response
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetUserGroupList
    def User.get_groups(params = {})
      TARGET.get([:GetUserGroupList, :v1, params.to_params].join('/')).parse_json
    end

    # Resolve Vanity URL
    # @param [Hash] params Parameters to pass to the API
    # @option params [String] :vanityurl The vanity URL part of a user's Steam profile URL. This
    #   is the basename of http://steamcommunity.com/id/ URLs.
    # @option params [String] :key Steam Api Key
    # @return [Hash] A hash containing the API response
    # @see http://wiki.teamfortress.com/wiki/WebAPI/ResolveVanityURL
    def User.resolve_vanity_url(params = {})
      TARGET.get([:ResolveVanityURL, :v0001, params.to_params].join('/')).parse_json
    end
=end
  end
end
