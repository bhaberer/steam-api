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

  def self.appid
    if @appid.nil?
      if ENV.key?('STEAM_APP_ID')
        @appid = ENV['STEAM_APP_ID'].to_s
      else
        fail ArgumentError, 'Please set your Steam APP ID.'
      end
    end
    @appid
  end

  def self.appid=(appid)
    @appid = appid
  end
end
