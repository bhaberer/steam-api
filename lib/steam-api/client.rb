# -*- encoding: utf-8 -*-
module Steam
  # Client object used to communicate with the steam webapi
  class Client
    def initialize(url)
      @conn = Faraday.new(url: url)
    end

    def get(resource, params: {}, key: Steam.apikey)
      params[:key] = key
      response = @conn.get resource, params
      JSON.parse(response.body)
    rescue JSON::ParserError
      { error: '500 Internal Server Error' }
    end
  end
end
