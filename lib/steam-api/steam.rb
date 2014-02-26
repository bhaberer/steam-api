# -*- encoding: utf-8 -*-
# Base class def
module Steam
  @apikey = ENV['STEAM_API_KEY']

  def self.apikey
    fail ArgumentError, 'Please set your Steam API key.' if @apikey.nil?
    @apikey
  end

  def self.apikey=(key)
    @apikey = key
  end
end
