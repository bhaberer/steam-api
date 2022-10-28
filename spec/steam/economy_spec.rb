# frozen_string_literal: true

describe Steam::Economy do
  describe '.asset_info' do
    let(:result) do
      described_class.asset_info(
        440, params: { class_count: 2, classid0: '195151', classid1: '16891096' }
      )
    end

    it 'returns data' do
      expect(result).not_to be_nil
    end

    it 'requires class params' do
      expect { described_class.asset_info(440) }.to raise_error(Steam::JSONError)
    end

    it 'allows users to query asset info' do
      expect(result).to match '195151' => a_kind_of(Hash), '16891096' => a_kind_of(Hash)
    end
  end

  describe '.asset_prices' do
    let(:result) { described_class.asset_prices(440) }

    it 'allows users to look up a list asset prices' do
      expect(result).not_to be_nil
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
