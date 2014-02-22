require 'spec_helper'

describe Steam do
  before(:all) do
    @apikey = Steam.apikey
  end

  after(:each) do
    Steam.apikey = @apikey
  end

  it 'should return a Steam API key if one is defined' do
    Steam.apikey.should_not be_nil
  end

  it 'should return an error if the Steam Key is missing' do
    Steam.apikey = nil
    lambda { Steam.apikey }
      .should raise_error(ArgumentError, /Please set your Steam API key/)
  end

  it 'should return a new value if set to a different API key' do
    old = Steam.apikey
    Steam.apikey = 'blah'
    Steam.apikey.should_not == old
    Steam.apikey.should == 'blah'
  end

  it 'should update the ENV variable if set' do
    Steam.apikey = 'test'
    ENV['STEAM_API_KEY'].should == 'test'
  end
end
