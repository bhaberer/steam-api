# frozen_string_literal: true

# Base class definition
module Steam
  class << self
    attr_writer :apikey

    def apikey
      return @apikey if @apikey

      raise ArgumentError, 'Please set your Steam API key.' unless ENV.key?('STEAM_API_KEY')

      @apikey = ENV.fetch('STEAM_API_KEY')
    end
  end
end
