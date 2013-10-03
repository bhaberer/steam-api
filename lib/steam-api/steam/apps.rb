# A Ruby DSL for communicating with the Steam Web API.
# @see https://developer.valvesoftware.com/wiki/Steam_Web_API
# @since 1.0.0
module Steam
  class Apps < Weary::Client
    domain 'http://api.steampowered.com/ISteamApps'
    # TARGET.timeout  = 30000

    # Get Steam Applications
    # @return [Hash] A list of objects containing the title and app ID of each program
    #   available in the store.
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetAppList
    get :get_all, '/GetApplist/v2'

    # Get Servers at Address
    # @param [Hash] params Parameters to pass to the API
    # @option params [String] :addr IP or IP:queryport to list
    # @return [Hash] A hash containing the API response
    get :get_servers, '/GetServersAtAddress/v1' do |resource|
      resource.optional :addr
    end

    # Check if a given version of an App is current
    # @param [Hash] params Parameters to pass to the API
    # @option params [Fixnum] appid AppID of game
    # @option params [Fixnum] version The installed version of the game
    # @return [Hash] A hash containing the API response
    # @see http://wiki.teamfortress.com/wiki/WebAPI/UpToDateCheck
    get :up_to_date, '/UpToDateCheck/v1/' do |resource|
      resource.required :appid, :version
    end
  end
end

