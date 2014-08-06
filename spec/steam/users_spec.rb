require 'spec_helper'

describe Steam::User do
  before(:each) do
    @playerid = 76561197993276293
    @playerid2 = 76561197969622382
  end

  describe '.friends' do
    it 'should allow users to check a friends for a user' do
      response = Steam::User.friends(@playerid)
      expect(response).to_not be_nil
    end

    it 'should allow users to check a friends for a user' do
      expect(Steam::User.friends(@playerid).map { |friend| friend.first.last })
        .to include(@playerid2.to_s)
    end

    it 'should return an error on a bad friend id' do
      expect(lambda { Steam::User.friends('765611') })
        .to raise_error
    end

    it 'should return  the same content for :friends and :all' do
      expect(Steam::User.friends(@playerid2, relationship: :friend))
        .to eq(Steam::User.friends(@playerid2, relationship: :all))
    end

    it 'should return an error on a bad friend id' do
      expect(lambda { Steam::User.friends(@playerid2, relationship: :sadsad) })
        .to raise_error(Steam::JSONError)
    end
  end

  describe '.bans' do
    it 'should allow users to check bans for a user' do
      expect(Steam::User.bans(@playerid))
        .to_not be_nil
    end

    it 'should return a blank list for bad ids' do
      expect(Steam::User.bans(7993276293))
        .to eq({ 'players' => [] })
    end

    it 'should allow users to check a bans for multiple steamids' do
      expect(Steam::User.bans([@player, @player2]))
        .to_not be_nil
    end
  end

  describe '.summary' do
    it 'should allow users to get a summary for a user' do
      expect(Steam::User.summary(@playerid))
        .to_not be_nil
    end

    it 'should allow users to check summaries for multiple accounts' do
      expect(Steam::User.summaries([@player, @player2]))
        .to_not be_nil
    end
  end

  describe '.vanity_to_steamid' do
    it 'should return values when they look up vanity urls' do
      expect(Steam::User.vanity_to_steamid('asmeroth'))
        .to_not be_nil
    end

    it 'should return the correct id when users look up vanity urls' do
      expect(Steam::User.vanity_to_steamid('asmeroth'))
        .to eq(@playerid.to_s)
    end
  end

  describe '.groups' do
    it 'should allow users to look groups a player is a member of' do
      expect(Steam::User.groups(@playerid))
        .to_not be_nil
    end

    it 'should return an accurate list of groups a player is a member of' do
      response = Steam::User.groups(@playerid)
      expect(response.map { |g| g.values.first })
        .to include '3640974'
    end
  end
end
