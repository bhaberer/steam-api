module Steam
  # Since the steam responses are so randomly inconsistant we're making a new
  #   class to manage the responses.
  # FIXME move all hash extensions here once the gem is finished and make
  class Response < Hash
    def parse_key(key)
      fail Steam::JSONError unless self.key?(key)
      self[key]
    end
  end
end

class Hash
  def parse_key(key)
    fail Steam::JSONError unless self.key?(key)
    self[key]
  end

  def check_success(success_condition: true)
    success = self.parse_key('success')
    fail Steam::SteamError unless success == success_condition
  end
end
