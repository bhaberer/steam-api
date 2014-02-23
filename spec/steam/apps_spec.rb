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

    it 'should capture json errors' do
      Steam::Apps.get_servers(addr: nil)
        .should == { error: '500 Internal Server Error' }
    end
  end

  describe '.up_to_date' do
    it 'should allow users to look up version info' do
      Steam::Apps.up_to_date(appid: 440, version: 10)
        .should_not be_nil
    end

    it 'should return a false up to date value if the verion is out of date' do
      check = Steam::Apps.up_to_date(appid: 440, version: 10)
      check['up_to_date'].should be_false
      check['version_is_listable'].should be_false
      check.should have_key('required_version')
      check['message'].should == 'Your server is out of date, please upgrade'
    end

    it 'should return a positive up to date value if the version is correct' do
      current = Steam::Apps.up_to_date(appid: 440, version: 10)['required_version']
      check = Steam::Apps.up_to_date(appid: 440, version: current)
      check['up_to_date'].should be_true
      check['version_is_listable'].should be_true
    end

    it 'should capture json errors' do
      Steam::Apps.up_to_date(appid: nil, version: 'foo')
        .should == { error: '500 Internal Server Error' }
    end
  end
end
