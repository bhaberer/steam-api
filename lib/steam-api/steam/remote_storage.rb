# -*- encoding: utf-8 -*-
module Steam
  # A Ruby DSL for communicating with the Steam Web API.
  # @see https://developer.valvesoftware.com/wiki/Steam_Web_API
  # @since 1.0.0
  class RemoteStorage
    # Get Published File Details
    # @param [Hash] params Parameters to pass to the API
    # @option params [Fixnum] :itemcount Number of items being requested
    # @option params [Fixnum] :publishedfileids Published file id to look up
    # @return [Hash] A hash containing the API response
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetPublishedFileDetails
    def self.published_file(params: {})
      response = client.get 'GetPublishedFileDetails/v1', params: params
      response
    end

    # Get UGC File Details
    # @param [Hash] params Parameters to pass to the API
    # @option params [String] :key Steam Api Key
    # @option params [Fixnum] :steamid If specified, only returns details
    #   if the file is owned by the SteamID specified
    # @option params [Fixnum] :ugcid ID of UGC file to get info for
    # @option params [Fixnum] :appid appID of product
    # @return [Hash] A hash containing the API response
    # @see http://wiki.teamfortress.com/wiki/WebAPI/GetUGCFileDetails
    def self.ugc_file(params: {})
      response = client.get 'GetUGCFileDetails/v1', params: params
      response
    end

    private

    def self.client
      build_client 'ISteamRemoteStorage'
    end
  end
end
