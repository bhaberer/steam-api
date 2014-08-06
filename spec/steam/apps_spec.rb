require 'spec_helper'

describe Steam::Apps do
  describe '.get_all' do
    it 'should allow users to look up a list of all apps' do
      expect(Steam::Apps.get_all)
        .to_not be_nil
    end

    it 'should allow users to look up a list of all apps' do
      game = Steam::Apps.get_all.first
      expect(game).to have_key 'appid'
      expect(game).to have_key 'name'
    end
  end

  describe '.get_servers' do
    it 'should allow users to look up a list of servers at an ip' do
      expect(Steam::Apps.get_servers(addr: '192.168.1.1'))
        .to_not be_nil
    end

    it 'should allow users to look up a list of servers at an ip' do
      expect(Steam::Apps.get_servers(addr: '192.168.1.1'))
        .to eq([])
    end
  end

  describe '.up_to_date' do
    it 'should allow users to look up version info' do
      expect(Steam::Apps.up_to_date(appid: 440, version: 10))
        .to_not be_nil
    end

    it 'should return a false up to date value if the verion is out of date' do
      check = Steam::Apps.up_to_date(appid: 440, version: 10)
      expect(check['up_to_date'])
        .to be_falsey
      expect(check['version_is_listable'])
        .to be_falsey
      expect(check)
        .to have_key('required_version')
      expect(check['message'])
        .to eq('Your server is out of date, please upgrade')
    end

    it 'should return a positive up to date value if the version is correct' do
      current = Steam::Apps.up_to_date(appid: 440, version: 10)['required_version']
      check = Steam::Apps.up_to_date(appid: 440, version: current)
      expect(check['up_to_date'])
        .to be_truthy
      expect(check['version_is_listable'])
        .to be_truthy
    end

    it 'should capture json errors' do
      expect(lambda { Steam::Apps.up_to_date(appid: nil, version: 'foo') })
        .to raise_error
    end
  end
end
