module Steam
  # A Ruby DSL for communicating with the Steam Web API.
  # @see https://developer.valvesoftware.com/wiki/Steam_Web_API
  # @since 1.0.0
  module Store
    #Get App Details
    # @param String appid The UUID of the Steam Application
    # @see https://wiki.teamfortress.com/wiki/User:RJackson/StorefrontAPI#appdetails
    def self.app_details(appid)
      response = client.get 'appdetails', params: { appids: appid}
      response 
    end

    private
      def self.client
        build_client '', base_url: Steam::Helpers::STORE_API_BASE_URL
      end
  end
end