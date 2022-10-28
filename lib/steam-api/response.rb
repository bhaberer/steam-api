# frozen_string_literal: true

module Steam
  # Since the steam responses are so randomly inconsistant we're making a new
  #   class to manage the responses.
  class Response < Hash
    def initialize(raw_response)
      super()

      raw_response.each do |key, value|
        self[key] =
          case value
          when Hash then self.class.new(value)
          else value
          end
      end
    end

    # Simple method to access a nested field, since Valve seems to like
    #   nesting their json a few levels on every request.
    # @param [String] key The key to extract from the hash
    def parse_key(key)
      raise Steam::JSONError unless key?(key)

      self[key]
    end

    # Many responses from the apis (but not all) include a success
    #   field, so this allows us to check it wiht minimal fuss.
    # @param [String] success_condition what the success condition should be
    # @return [Boolean] Returns true or raises an exception.
    def check_success(success_condition: true)
      success = parse_key('success')
      raise Steam::SteamError unless success == success_condition

      true
    end
  end
end
