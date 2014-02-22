# -*- encoding: utf-8 -*-
module Steam
  # A Ruby DSL for communicating with the Steam Web API.
  # @see https://developer.valvesoftware.com/wiki/Steam_Web_API
  # @since 1.0.0
  module Apps

    # Get Steam Applications
    # @return [Hash] A list of objects containing the title and app ID of each program
    #   available in the store.
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetAppList
    def self.get_all
      response = build_client.get 'GetApplist/v2'
      response = JSON.parse(response.body)

      fail Steam::JSONError unless response.key?('applist')
      response = response['applist']
      fail Steam::JSONError unless response.key?('apps')
      response = response['apps']
      response
      rescue JSON::ParserError
        { error: '500 Internal Server Error' }
    end

    # Get Servers at Address
    # @param [Hash] params Parameters to pass to the API
    # @option params [String] :addr IP or IP:queryport to list
    # @return [Hash] A hash containing the API response
    def self.get_servers(addr: nil)
      response = build_client.get 'GetServersAtAddress/v1',
                                  params: { addr: URI.escape(addr) }
      response = JSON.parse(response.body)['response']
      fail Steam::JSONError unless response.key?('success') &&
                                   response.key?('servers')
      fail Steam::SteamError unless response['success']
      response['servers']
      rescue JSON::ParserError
        { error: '500 Internal Server Error' }
    end

    # Check if a given version of an App is current
    # @param [Hash] params Parameters to pass to the API
    # @option params [Fixnum] appid AppID of game
    # @option params [Fixnum] version The installed version of the game
    # @return [Hash] A hash containing the API response
    # @see http://wiki.teamfortress.com/wiki/WebAPI/UpToDateCheck
    def self.up_to_date(appid: nil, version: nil)
      response = build_client.get 'UpToDateCheck/v1',
                                  params: { appid: appid, version: version }
      response = JSON.parse(response.body)['response']
      fail Steam::JSONError unless response.key?('success') &&
                                   response['success']
      response.delete('success')
      response
      rescue JSON::ParserError
        { error: '500 Internal Server Error' }
    end

    private

    def self.build_client
      Steam::Client.new('http://api.steampowered.com/ISteamApps')
    end
  end
end
