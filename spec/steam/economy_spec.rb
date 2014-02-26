require 'spec_helper'

describe Steam::Economy do
  describe '.asset_info' do
    it 'should allow users to look up a list of all apps' do
      Steam::Economy.asset_info(440, params: { class_count: 2,
                                               classid0: 195151,
                                               classid1: 16891096 })
        .should_not be_nil
    end

    it 'should require class params' do
      lambda { Steam::Economy.asset_info(440) }
        .should raise_error
    end

    it 'should allow users to query asset info' do
      result = Steam::Economy.asset_info(440, params: { class_count: 2,
                                                        classid0: 195151,
                                                        classid1: 16891096 })
      result.should have_key('195151')
      result.should have_key('16891096')
    end
  end

  describe '.asset_prices' do
    it 'should allow users to look up a list asset prices' do
      Steam::Economy.asset_prices(440)
        .should_not be_nil
    end

    it 'should allow return a list of assets' do
      Steam::Economy.asset_prices(440)
        .should have_key('assets')
    end

    it 'should allow return a list of asset tags' do
      Steam::Economy.asset_prices(440)
        .should have_key('tags')
    end

    it 'should allow return a list of asset tag ids' do
      Steam::Economy.asset_prices(440)
        .should have_key('tag_ids')
    end
  end
end
