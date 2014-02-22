module Steam
  module Economy < Weary::Client
    domain 'http://api.steampowered.com/ISteamEconomy/'

    # Get Asset Class Info
    # @param [Hash] params Parameters to pass to the API
    # @option params [String] :key Steam Api Key
    # @option params [String] :appid The application ID for the Steam Game.
    # @option params [Fixnum] :class_count The number of classids passed to the request.
    # @option params [Fixnum] :classidN Where N can be a series of sequential numbers to form a list of class IDs. [1] [2]
    # @option params [Fixnum] :instanceidN Instance ID of the nth class. (Optional)
    # @option params [String] :language The ISO639-1 language code for the language all localized
    #   strings should be returned in. Not all strings have been translated to every language.
    #   If a language does not have a string, the English string will be returned instead. If this
    #   parameter is omitted the string token will be returned for the strings. (Optional)
    # @return [Hash] A hash containing the API response
    # @see http://wiki.teamfortress.com/wiki/WebAPI/UpToDateCheck
    get :asset_info '/GetAssetClassInfo/v0001' do |resource|
      resource.required :key, :appid, :class_count, :classidN
      resource.optional :instanceidN, :language
    end

    # Get Asset Prices
    # @param [Hash] params Parameters to pass to the API
    # @option params [String] :key Steam Api Key
    # @option params [String] :appid The application ID for the Steam Game.
    # @option params [String] :language The ISO639-1 language code for the language all localized
    #   strings should be returned in. Not all strings have been translated to every language.
    #   If a language does not have a string, the English string will be returned instead. If this
    #   parameter is omitted the string token will be returned for the strings. (Optional)
    # @option params [String] :currency The ISO 4217 code for currency specific filtering. (Optional)
    # @return [Hash] A hash containing the API response
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetAssetPrices
    get :asset_prices, '/GetAssetPrices/v0001' do |resource|
      resource.required :key, :appid
      resource.optional :language, :currency
    end
  end
end
