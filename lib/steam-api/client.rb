# -*- encoding: utf-8 -*-
module Steam
  # Client object used to communicate with the steam webapi
  class Client
    def initialize(url)
      @conn = Faraday.new(url: url)
    end

    def get(resource, params: {}, key: Steam.apikey)
      params[:key] = key
      @conn.get resource, params
    end
  end
end
