# frozen_string_literal: true

module Steam
  # Client object used to communicate with the steam webapi
  class Client
    # @param [String] api The endpoint of the API
    # @param [String] base_url the root uri for steam's API
    # @return [Steam::Client] The Client
    def initialize(api, base_url: 'https://api.steampowered.com')
      url = File.join(base_url, api)
      @conn = Faraday.new(url: url)
    end

    # overriding the get method of Faraday to make things simpler.
    # @param [String] resource the resource you're targeting
    # @param [Hash] params Hash of parameters to pass to the resource
    # @param [String] key Steam API key
    def get(resource, params: {}, key: Steam.apikey)
      params[:key] = key
      response = @conn.get resource, params
      response = JSON.parse(response.body)
      response = Response.new response
    rescue JSON::ParserError
      puts response.body
      # If the steam web api returns an error it's virtually never in json, so
      #   lets pretend that we're getting some sort of consistant response
      #   for errors.
      raise Steam::UnavailableError if response.status == '503'

      Response.new error: '500 Internal Server Error'
    end
  end
end
