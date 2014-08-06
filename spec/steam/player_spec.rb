require 'spec_helper'

describe Steam::Player do
  before(:each) do
    @playerid = 76561197993276293
  end

  describe '.owned_games' do
    it 'should allow users to retrieve a list of games' do
      expect(Steam::Player.owned_games(@playerid))
        .to_not be_nil
    end

    it 'should allow users to retrieve a list of games' do
      expect(Steam::Player.owned_games(@playerid))
        .to have_key('game_count')
    end

    it 'should allow users to retrieve a list of games' do
      expect(Steam::Player.owned_games(@playerid))
        .to have_key('games')
    end
  end

  describe '.recently_played_games' do
    it 'should allow users to list a players recent games' do
      expect(Steam::Player.recently_played_games(@playerid))
        .to_not be_nil
    end

    it 'should allow users to list a players recent games' do
      expect(Steam::Player.recently_played_games(@playerid))
        .to have_key 'total_count'
    end
  end

  describe '.steam_level' do
    it 'should allow users to retrieve a users steam level' do
      expect(Steam::Player.steam_level(@playerid))
        .to_not be_nil
    end

    it 'should allow users to retrieve a users steam level' do
      expect(Steam::Player.steam_level(@playerid))
        .to be_a(Fixnum)
    end
  end

  describe '.badges' do
    it 'should allow a user to retrieve badges for a player' do
      expect(Steam::Player.badges(@playerid))
        .to_not be_nil
    end

    it 'should allow a user to retrieve badges for a player' do
      expect(Steam::Player.badges(@playerid))
        .to have_key 'badges'
    end

    it 'should allow a user to retrieve badges for a player' do
      expect(Steam::Player.badges(@playerid))
        .to have_key 'player_level'
    end

    it 'should allow a user to retrieve badges for a player' do
      expect(Steam::Player.badges(@playerid))
        .to have_key 'player_xp'
    end

    it 'should allow a user to retrieve badges for a player' do
      expect(Steam::Player.badges(@playerid))
        .to have_key 'player_xp_needed_current_level'
    end

    it 'should allow a user to retrieve badges for a player' do
      expect(Steam::Player.badges(@playerid))
        .to have_key 'player_xp_needed_to_level_up'
    end
  end

  describe '.community_badge_progress' do
    it 'should allow a user to retrieve community badge info for a player' do
      expect(Steam::Player.community_badge_progress(@playerid))
        .to_not be_nil
    end

    it 'should allow a user to retrieve community badge info for a player' do
      quest = Steam::Player.community_badge_progress(@playerid).first
      expect(quest).to have_key 'questid'
      expect(quest).to have_key 'completed'
    end
  end
end
