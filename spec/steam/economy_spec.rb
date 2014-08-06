require 'spec_helper'

describe Steam::Economy do
  describe '.asset_info' do
    it 'should allow users to look up a list of all apps' do
      asset = Steam::Economy.asset_info(440, params: { class_count: 2,
                                                       classid0: 195151,
                                                       classid1: 16891096 })
      expect(asset).to_not be_nil
    end

    it 'should require class params' do
      expect(lambda { Steam::Economy.asset_info(440) })
        .to raise_error
    end

    it 'should allow users to query asset info' do
      result = Steam::Economy.asset_info(440, params: { class_count: 2,
                                                        classid0: 195151,
                                                        classid1: 16891096 })
      expect(result).to have_key('195151')
      expect(result).to have_key('16891096')
    end
  end

  describe '.asset_prices' do
    it 'should allow users to look up a list asset prices' do
      expect(Steam::Economy.asset_prices(440))
        .to_not be_nil
    end

    it 'should allow return a list of assets' do
      expect(Steam::Economy.asset_prices(440))
        .to have_key('assets')
    end

    it 'should allow return a list of asset tags' do
      expect(Steam::Economy.asset_prices(440))
        .to have_key('tags')
    end

    it 'should allow return a list of asset tag ids' do
      expect(Steam::Economy.asset_prices(440))
        .to have_key('tag_ids')
    end
  end
end
