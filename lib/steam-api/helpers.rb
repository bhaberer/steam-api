module Steam
  # Helper Module
  module Helpers
    # Conveniance method to build clients
    # @param [String] api The endpoint of the API
    # @param [String] base_url the root uri for steam's API
    # @return [Steam::Client] The Client
    def build_client(api, base_url: 'https://api.steampowered.com')
      Steam::Client.new([base_url, api].join('/'))
    end


    STORE_API_BASE_URL = 'https://store.steampowered.com/api'
  end
end
