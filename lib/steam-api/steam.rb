# frozen_string_literal: true

# Base class definition
module Steam
  @apikey = ENV['STEAM_API_KEY']

  class << self
    attr_writer :apikey

    def apikey
      if @apikey.nil?
        raise ArgumentError, 'Please set your Steam API key.' unless ENV.key?('STEAM_API_KEY')

        @apikey = ENV['STEAM_API_KEY']
      end
      @apikey
    end
  end
end
