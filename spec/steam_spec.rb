require 'spec_helper'

describe Steam do
  before(:all) do
    @apikey = Steam.apikey
  end

  after(:each) do
    Steam.apikey = @apikey
  end

  it 'should return a Steam API key if one is defined' do
    expect(Steam.apikey).to_not be_nil
  end

  it 'should return an error if the Steam Key is missing' do
    Steam.apikey = nil
    ENV['STEAM_API_KEY'] = nil
    expect(lambda { Steam.apikey })
      .to raise_error(ArgumentError, /Please set your Steam API key/)
  end

  it 'should return a new value if set to a different API key' do
    old = Steam.apikey
    Steam.apikey = 'blah'
    expect(Steam.apikey).to_not eq(old)
    expect(Steam.apikey).to eq('blah')
  end

  it 'should allow users to set the apikey post init using ENV' do
    Steam.apikey = nil
    ENV['STEAM_API_KEY'] = nil
    expect(lambda { Steam.apikey })
      .to raise_error(ArgumentError, /Please set your Steam API key/)
    ENV['STEAM_API_KEY'] = @apikey
    expect(Steam.apikey).to eq(@apikey)
  end
end
