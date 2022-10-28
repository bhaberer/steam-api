# frozen_string_literal: true

module Steam
  # A Ruby DSL for communicating with the Apps portion of the Steam Web API.
  # @see https://developer.valvesoftware.com/wiki/Steam_Web_API
  # @since 1.0.0
  module Apps
    class << self
      # Get Steam Applications
      # @return [Hash] A list of objects containing the title and app ID of
      #   each program available in the store.
      # @see http://wiki.teamfortress.com/wiki/WebAPI/GetAppList
      def get_all
        client.get('GetApplist/v2').parse_key('applist').parse_key('apps')
      end

      # Get Servers at Address
      # @param [String] addr IP or IP:queryport to list
      # @return [Hash] A hash containing the API response
      # @see http://wiki.teamfortress.com/wiki/WebAPI/GetServersAtAddress
      def get_servers(addr: nil, api_version: 'v1')
        response = client.get(
          "GetServersAtAddress/#{api_version}", params: { addr: ERB::Util.url_encode(addr) }
        )
        response = response.parse_key('response')
        response.check_success
        response.parse_key('servers')
      end

      # Check if a given version of an App is current
      # @param [Fixnum] appid AppID of game
      # @param [Fixnum] version The installed version of the game
      # @return [Hash] A hash containing the API response
      # @see http://wiki.teamfortress.com/wiki/WebAPI/UpToDateCheck
      def up_to_date(appid: nil, version: 'v1', api_version: 'v1')
        response = client.get(
          "UpToDateCheck/#{api_version}", params: { appid: appid, version: version }
        )
        response = response.parse_key('response')
        response.check_success
        response.delete('success')
        response
      end

      def client
        Steam::Client.new 'ISteamApps'
      end
    end
  end
end
