module Steam
  # A Ruby DSL for communicating with the Apps portion of the Steam Web API.
  # @see https://developer.valvesoftware.com/wiki/Steam_Web_API
  # @since 1.0.0
  module Apps
    # Get Steam Applications
    # @return [Hash] A hash of objects containing the title and app ID of
    #   each program available in the store.
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetAppList
    def self.get_all
      app_list = {}
      response = client.get('GetApplist/v2')
                       .parse_key('applist')
                       .parse_key('apps')

      # Render the list of hashes into one large hash
      response.collect do |app|
        app_list[app.dig('appid')] = app.dig('name')
      end

      app_list
    end

    # Get Servers at Address
    # @param [String] addr IP or IP:queryport to list
    # @return [Hash] A hash containing the API response
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetServersAtAddress
    def self.get_servers(addr: nil, api_version: 'v1')
      response = client.get "GetServersAtAddress/#{api_version}",
                            params: { addr: ERB::Util.url_encode(addr) }
      response = response.parse_key('response')
      response.check_success
      response.parse_key('servers')
    end

    # Check if a given version of an App is current
    # @param [Fixnum] appid AppID of game
    # @param [Fixnum] version The installed version of the game
    # @return [Hash] A hash containing the API response
    # @see http://wiki.teamfortress.com/wiki/WebAPI/UpToDateCheck
    def self.up_to_date(appid: nil, version: 'v1', api_version: 'v1')
      response = client.get "UpToDateCheck/#{api_version}",
                            params: { appid: appid, version: version }
      response = response.parse_key('response')
      response.check_success
      response.delete('success')
      response
    end

    def self.client
      build_client 'ISteamApps'
    end
  end
end
