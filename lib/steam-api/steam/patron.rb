require 'json'

module Patron
  class Response
    # Parse the JSON response of the Response's body into a standard ruby object.
    # @return [Hash,String] The parsed body of the Response Object, or an Error.
    def parse_json
      body = self.body
      begin
        JSON.parse(body)
      rescue JSON::ParserError
        return { :error => 'Problem Parsing the JSON Response from the API', :body => body }
      end
    end
  end
end
