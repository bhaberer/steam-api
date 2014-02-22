# A Ruby DSL for communicating with the Steam Web API.
# @see https://developer.valvesoftware.com/wiki/Steam_Web_API
# @since 1.0.0
module Steam
  class News < Weary::Client
    domain 'http://api.steampowered.com/ISteamNews/'

    # Get News for App
    # @param [Hash] params Parameters to pass to the API
    # @option params [String] :appid The application ID for the Steam Game.
    # @option params [String] :key Steam Api Key
    # @option params [Fixnum] :count How many news enties you want to get returned. (Optional)
    # @option params [Fixnum] :maxlength Maximum length of each news entry. (Optional)
    # @option params [Fixnum] :enddate Unix timestamp, returns posts before this date. (Optional)
    # @option params [String] :feeds Commma-seperated list of feed names to return news for. (Optional)
    # @return [Hash] A hash object of the latest news items for a game specified by its appID.
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetNewsForApp
    get :get, '/GetNewsForApp/v0002' do |resource|
      resource.required :appid, :key
      resource.optional :count, :maxlength, :enddate, :feeds
    end
  end
end
