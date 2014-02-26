module Steam
  module Helpers
    def build_client(api, base_url: 'http://api.steampowered.com')
      Steam::Client.new([base_url, api].join('/'))
    end
  end
end

