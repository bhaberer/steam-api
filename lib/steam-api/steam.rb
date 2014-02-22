# -*- encoding: utf-8 -*-
# Base class def
module Steam
  def self.apikey
    return ENV['STEAM_API_KEY'] if ENV.key?('STEAM_API_KEY')
    fail ArgumentError, 'Please set your Steam API key.'
  end

  def self.apikey=(key)
    ENV['STEAM_API_KEY'] = key
  end
end
