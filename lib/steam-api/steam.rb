module Steam
  def Steam.apikey
    return ENV['STEAM_API_KEY'] if ENV.key?('STEAM_API_KEY')

    raise ArgumentError, 'Please set your Steam API key.'
  end

  def Steam.apikey=(key)
    ENV['STEAM_API_KEY'] = key
  end
end
