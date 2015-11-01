require 'spec_helper'

describe Steam::Economy do
  describe '.asset_info' do
    let(:result) { Steam::Economy.asset_info(440,
                                             params: { class_count: 2,
                                                       classid0: 195151,
                                                       classid1: 16891096 })}

    it 'returns data' do
      expect(result).to_not be_nil
    end

    it 'requires class params' do
      expect { Steam::Economy.asset_info(440) }.to raise_error
    end

    it 'allows users to query asset info' do
      expect(result).to have_key('195151')
      expect(result).to have_key('16891096')
    end
  end

  describe '.asset_prices' do
    let(:result) { Steam::Economy.asset_prices(440) }

    it 'allows users to look up a list asset prices' do
      expect(result).to_not be_nil
    end

    it 'returns a list of assets' do
      expect(result).to have_key('assets')
    end

    it 'returns a list of asset tags' do
      expect(result).to have_key('tags')
    end

    it 'returns a list of asset tag ids' do
      expect(result).to have_key('tag_ids')
    end
  end
end
