# frozen_string_literal: true

describe Steam::News do
  describe '.get' do
    let(:result) { Steam::News.get(440) }

    it 'allow users to look up a news list' do
      expect(result).to_not be_nil
    end

    it 'returns the first 20 articles' do
      expect(result.count).to eq(20)
    end
  end
end
