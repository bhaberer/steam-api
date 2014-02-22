require 'spec_helper'

describe Steam::Apps do
  describe '.get_all' do
    it 'should allow users to look up a list of all apps' do
      Steam::Apps.get_all
        .should_not be_nil
    end

    it 'should allow users to look up a list of all apps' do
      game = Steam::Apps.get_all.first
      game.should have_key 'appid'
      game.should have_key 'name'
    end
  end

  describe '.get_servers' do
    it 'should allow users to look up a list of servers at an ip' do
      Steam::Apps.get_servers(addr: '192.168.1.1')
        .should_not be_nil
    end

    it 'should allow users to look up a list of servers at an ip' do
      Steam::Apps.get_servers(addr: '192.168.1.1')
        .should == []
    end
  end

  describe '.up_to_date' do
    it 'should allow users to look up version info' do
      Steam::Apps.up_to_date(appid: 440, version: 10)
        .should_not be_nil
    end

    it 'should return a false up to date value if info' do
      Steam::Apps.up_to_date(appid: 440, version: 10)
        .should == { 'up_to_date' => false,
                     'version_is_listable' => false,
                     'required_version' => 2123087,
                     'message' =>'Your server is out of date, please upgrade' }
    end
  end
end
