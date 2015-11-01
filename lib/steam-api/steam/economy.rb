# -*- encoding: utf-8 -*-
module Steam
  # A Ruby DSL for communicating with the Steam Web API.
  # @see https://developer.valvesoftware.com/wiki/Steam_Web_API
  # @since 1.0.0
  module Economy
    # Get Asset Class Info
    # @param [String] appid The application ID for the Steam Game.
    # @param [Hash] params Parameters to pass to the API
    # @option params [Fixnum] :class_count The number of classids passed to
    #   the request.
    # @option params [Fixnum] :classidN Where N can be a series of sequential
    #   numbers to form a list of class IDs. [1] [2]
    # @option params [Fixnum] :instanceidN Instance ID of the nth class.
    # @option params [String] :language The ISO639-1 language code for the
    #   language all localized strings should be returned in. Not all strings
    #   have been translated to every language.
    #   If a language does not have a string, the English string will be
    #   returned instead. If this parameter is omitted the string token will
    #   be returned for the strings.
    # @return [Hash] A hash containing the API response
    # @see http://wiki.teamfortress.com/wiki/WebAPI/UpToDateCheck
    def self.asset_info(appid, params: {})
      params[:appid] = appid
      response = client.get 'GetAssetClassInfo/v1', params: params
      parse_response(response)
    end

    # Get Asset Prices
    # @param [String] appid The application ID for the Steam Game.
    # @param [String] language The ISO639-1 language code for the language
    #   all localized strings should be returned in. Not all strings have been
    #   translated to every language.
    #   If a language does not have a string, the English string will be
    #   returned instead. If this parameter is omitted the string token will
    #   be returned for the strings. (Optional)
    # @param [String] currency The ISO 4217 code for currency specific
    #   filtering. (Optional)
    # @return [Hash] A hash containing the API response
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetAssetPrices
    def self.asset_prices(appid, language: nil, currency: nil)
      params = { appid: appid }
      params[:language] = language unless language.nil?
      params[:currency] = currency unless currency.nil?
      response = client.get 'GetAssetPrices/v1',
                            params: params
      parse_response(response)
    end

    private

    def self.client
      build_client 'ISteamEconomy'
    end

    def self.parse_response(response)
      response = response.parse_key('result')
      response.check_success
      response.delete('success')
      response
    end
  end
end
