module Steam
  module Helpers
    # Conveniance method to build clients
    # @param [String] api The endpoint of the API
    # @param [String] base_url the root uri for steam's API
    # @return [Steam::Client] The Client
    def build_client(api, base_url: 'https://api.steampowered.com')
      Steam::Client.new([base_url, api].join('/'))
    end
  end
end

