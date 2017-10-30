# -*- encoding: utf-8 -*-
module Steam
  # A Ruby DSL for communicating with the Steam Web API.
  # @see https://developer.valvesoftware.com/wiki/Steam_Web_API
  # @since 1.1.0
  module Inventory
    # Get user's inventory.
    # @option params [String] :steamid The SteamID of the account.
    # @param [Hash] params Parameters to pass to the API
    # @see https://partner.steamgames.com/doc/webapi/IInventoryService#GetInventory
    def self.get_inventory(steamid, params = {})
      params[:steamid] = steamid
      params[:appid] = Steam.appid
      response = client.get 'GetInventory/v1', params: params
      p JSON.parse(response['response']['item_json'])
    end

    private

    def self.client
      build_client 'IInventoryService'
    end
  end
end