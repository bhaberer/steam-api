require 'spec_helper'

describe Steam::User do

  describe '.friends' do
    it 'should allow users to check a friends for a user' do
      response = Steam::User.friends(76561197993276293)
      response.should_not be_nil
    end

    it 'should allow users to check a friends for a user' do
      Steam::User.friends(76561197993276293)
        .map {|f| f.first.last }
        .should include('76561197969622382')
    end

    it 'should return an error on a bad friend id' do
      Steam::User.friends('765611')
        .should == { error: '500 Internal Server Error' }
    end

    it 'should return  the same content for :friends and :all' do
      Steam::User.friends('76561197969622382', relationship: :friend)
        .should == Steam::User.friends('76561197969622382', relationship: :all)
    end

    it 'should return an error on a bad friend id' do
      lambda { Steam::User.friends('76561197969622382', relationship: :sadsad) }
        .should raise_error(Steam::JSONError)
    end
  end

  describe '.bans' do
    it 'should allow users to check bans for a user' do
      Steam::User.bans(76561197993276293)
        .should_not be_nil
    end

    it 'should return a blank list for bad ids' do
      Steam::User.bans(7993276293)
        .should == { 'players' => [] }
    end

    it 'should allow users to check a bans for multiple steamids' do
      Steam::User.bans([76561197993276293, 76561197966796383])
        .should_not be_nil
    end
  end

  describe '.summary' do
    it 'should allow users to get a summary for a user' do
      Steam::User.summary(76561197993276293)
        .should_not be_nil
    end

    it 'should allow users to check summaries for multiple accounts' do
      Steam::User.summaries([76561197993276293, 76561197966796383])
        .should_not be_nil
    end
  end

  describe '.vanity_to_steamid' do
    it 'should return values when they look up vanity urls' do
      Steam::User.vanity_to_steamid('asmeroth')
        .should_not be_nil
    end

    it 'should return the correct id when users look up vanity urls' do
      Steam::User.vanity_to_steamid('asmeroth')
        .should == '76561197993276293'
    end
  end

  describe '.groups' do
    it 'should allow users to look groups a player is a member of' do
      Steam::User.groups(76561197993276293)
        .should_not be_nil
    end

    it 'should return an accurate list of groups a player is a member of' do
      response = Steam::User.groups(76561197993276293)
      response.map { |g| g.values.first }
        .should include '3640974'
    end
  end
end
