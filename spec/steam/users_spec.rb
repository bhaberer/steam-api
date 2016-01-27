require 'spec_helper'

describe Steam::User do
  let(:playerid) { 76561197993276293 }
  let(:playerid2) { 76561197969622382 }

  describe '.friends' do
    let(:result) { Steam::User.friends(playerid) }

    it 'allows users to check a friends for a user' do
      expect(result).to_not be_nil
    end

    it 'returns a list of friends of a user' do
      expect(result.map { |friend| friend.first.last }).to include(playerid2.to_s)
    end

    it 'raises an error on a bad friend id' do
      expect { Steam::User.friends('765611') }.to raise_error(Steam::JSONError)
    end

    it 'returns the same content for :friends and :all' do
      friends = Steam::User.friends(playerid2, relationship: :friend)
      all_friends = Steam::User.friends(playerid2, relationship: :all)
      expect(friends).to eq(all_friends)
    end

    it 'returns an error on a bad friend relationship' do
      expect { Steam::User.friends(playerid2, relationship: :sadsad) }.to raise_error(Steam::JSONError)
    end
  end

  describe '.bans' do
    it 'allows users to check bans for a user' do
      expect(Steam::User.bans(playerid)).to_not be_nil
    end

    it 'returns a blank list for bad ids' do
      expect(Steam::User.bans(7993276293)).to eq({ 'players' => [] })
    end

    it 'allow users to check bans for multiple steamids' do
      expect(Steam::User.bans([playerid, playerid2])).to_not be_nil
    end
  end

  describe '.summary' do
    it 'allows users to get a summary for a user' do
      expect(Steam::User.summary(playerid)).to_not be_nil
    end

    it 'allows users to check summaries for multiple accounts' do
      expect(Steam::User.summaries([playerid, playerid2])).to_not be_nil
    end
  end

  describe '.vanity_to_steamid' do
    let(:result) { Steam::User.vanity_to_steamid('asmeroth') }

    it 'return values when they look up vanity urls' do
      expect(result).to_not be_nil
    end

    it 'returns the correct id when users look up vanity urls' do
      expect(result).to eq(playerid.to_s)
    end
  end

  describe '.groups' do
    let(:result) { Steam::User.groups(playerid) }

    it 'allow users to look up a users groups' do
      expect(result).to_not be_nil
    end

    it 'returns an accurate list of groups a player is a member of' do
      expect(result.map { |g| g.values.first }).to include('3640974')
    end
  end
end
