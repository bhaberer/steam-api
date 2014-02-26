require 'spec_helper'

describe Steam::News do
  describe '.get' do
    it 'should allow users to look up a list news for an app' do
      Steam::News.get(440)
        .should_not be_nil
    end

    it 'should allow users to look up a list news for an app' do
      news = Steam::News.get(440)
      news.count.should == 20
    end
  end
end
