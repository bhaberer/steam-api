# Base class def
module Steam
  @apikey = ENV['STEAM_API_KEY']

  def self.apikey
    if @apikey.nil?
      unless ENV.key?('STEAM_API_KEY')
        raise ArgumentError, 'Please set your Steam API key.'
      end

      @apikey = ENV['STEAM_API_KEY']
    end
    @apikey
  end

  def self.apikey=(key)
    @apikey = key
  end
end
