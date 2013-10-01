require 'spec_helper'

describe Steam do

  before(:all) do
    @appkey = ENV['STEAM_API_KEY']
  end

  describe Steam::Apps do
    it 'should return a success on a query for games' do
      Steam::Apps.get_all.status.
        should == 200
    end

    it 'should return a json array of all SteamApps' do
      apps = Steam::Apps.get_all.parse_json
      apps.should have_key('applist')
    end
  end
end
