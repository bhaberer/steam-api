require 'spec_helper'

describe Steam::News do
  describe '.get' do
    it 'should allow users to look up a list news for an app' do
      expect(Steam::News.get(440))
        .to_not be_nil
    end

    it 'should allow users to look up a list news for an app' do
      news = Steam::News.get(440)
      expect(news.count).to eq(20)
    end
  end
end
