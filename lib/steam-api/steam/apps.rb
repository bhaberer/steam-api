# -*- encoding: utf-8 -*-
module Steam
  # A Ruby DSL for communicating with the Apps portion of the Steam Web API.
  # @see https://developer.valvesoftware.com/wiki/Steam_Web_API
  # @since 1.0.0
  module Apps
    # Get Steam Applications
    # @return [Hash] A list of objects containing the title and app ID of each program
    #   available in the store.
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetAppList
    def self.get_all
      response = client.get('GetApplist/v2')
        .parse_key('applist')
        .parse_key('apps')
      response
    end

    # Get Servers at Address
    # @param [String] addr IP or IP:queryport to list
    # @return [Hash] A hash containing the API response
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetServersAtAddress
    def self.get_servers(addr: nil)
      response = client.get 'GetServersAtAddress/v1',
                            params: { addr: URI.escape(addr) }
      response = response.parse_key('response')
      response.check_success
      response.parse_key('servers')
    end

    # Check if a given version of an App is current
    # @param [Fixnum] appid AppID of game
    # @param [Fixnum] version The installed version of the game
    # @return [Hash] A hash containing the API response
    # @see http://wiki.teamfortress.com/wiki/WebAPI/UpToDateCheck
    def self.up_to_date(appid: nil, version: nil)
      response = client.get 'UpToDateCheck/v1',
                            params: { appid: appid, version: version }
      response = response.parse_key('response')
      response.check_success
      response.delete('success')
      response
    end

    private

    def self.client
      build_client 'ISteamApps'
    end
  end
end
