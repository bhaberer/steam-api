# -*- encoding: utf-8 -*-
# Base class def
module Steam
  @apikey = ENV['STEAM_API_KEY']

  def self.apikey
    if @apikey.nil?
      if ENV.key?('STEAM_API_KEY')
        @apikey = ENV['STEAM_API_KEY']
      else
        fail ArgumentError, 'Please set your Steam API key.'
      end
    end
    @apikey
  end

  def self.apikey=(key)
    @apikey = key
  end
end
