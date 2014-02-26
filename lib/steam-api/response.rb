module Steam
  # Since the steam responses are so randomly inconsistant we're making a new
  #   class to manage the responses.
  # FIXME move all hash extensions here once the gem is finished and make
  class Response < Hash
  #   def parse_key(key)
  #     fail Steam::JSONError unless self.key?(key)
  #     self[key]
  #   end
  end
end

class Hash
  # Simple method to access a nested field, since Valve seems to like
  #   nesting their json a few levels on every request.
  # @param [String] key The key to extract from the hash
  def parse_key(key)
    fail Steam::JSONError unless self.key?(key)
    self[key]
  end

  # Many responses from the apis (but not all) include a success
  #   field, so this allows us to check it wiht minimal fuss.
  # @param [String] success_condition what the success condition should be
  # @return [Boolean] Returns true or raises an exception.
  def check_success(success_condition: true)
    success = self.parse_key('success')
    fail Steam::SteamError unless success == success_condition
    true
  end
end
