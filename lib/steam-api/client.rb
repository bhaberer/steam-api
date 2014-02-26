# -*- encoding: utf-8 -*-
module Steam
  # Client object used to communicate with the steam webapi
  class Client
    def initialize(url)
      @conn = Faraday.new(url: url)
    end

    # overriding the get method of Faraday to make things simpler.
    # @param [String] resource the resource you're targeting
    # @param [Hash] params Hash of parameters to pass to the resource
    # @param [String] key Steam API key
    def get(resource, params: {}, key: Steam.apikey)
      params[:key] = key
      response = @conn.get resource, params
      JSON.parse(response.body)
    rescue JSON::ParserError
      { error: '500 Internal Server Error' }
    end
  end
end
