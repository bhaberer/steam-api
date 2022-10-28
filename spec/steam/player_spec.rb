# frozen_string_literal: true

describe Steam::Player do
  let(:playerid) { '76561198039590772' }

  describe '.owned_games' do
    let(:result) { described_class.owned_games(playerid) }

    it 'allows users to retrieve a list of games' do
      expect(result).not_to be_nil
    end

    it 'returns a game_count' do
      expect(result).to have_key('game_count')
    end

    it 'returns a list of games' do
      expect(result).to have_key('games')
    end
  end

  describe '.recently_played_games' do
    let(:result) { described_class.recently_played_games(playerid) }

    it 'allows users to list a players recent games' do
      expect(result).not_to be_nil
    end

    it 'returns total_count' do
      expect(result).to have_key('total_count')
    end

    it 'returns the list of games' do
      expect(result).to have_key('games')
    end

    it 'returns the recent playtime for games' do
      expect(result['games'].first).to have_key('playtime_2weeks')
    end

    it 'returns the full playtime for games' do
      expect(result['games'].first).to have_key('playtime_forever')
    end
  end

  describe '.steam_level' do
    let(:result) { described_class.steam_level(playerid) }

    it 'allows users to retrieve a users steam level' do
      expect(result).not_to be_nil
    end

    it 'returns the level number' do
      expect(result).to be_a(Integer)
    end
  end

  describe '.badges' do
    let(:result) { described_class.badges(playerid) }

    it 'allows a user to retrieve badges for a player' do
      expect(result).not_to be_nil
    end

    it 'returns a list of badges' do
      expect(result).to have_key('badges')
    end

    it 'returns the player level' do
      expect(result).to have_key('player_level')
    end

    it 'returns the player level as a number' do
      expect(result['player_level']).to be_a(Integer)
    end

    it 'returns the players current xp' do
      expect(result).to have_key('player_xp')
    end

    it 'returns the xp a player needed to reach thier current level' do
      expect(result).to have_key('player_xp_needed_current_level')
    end

    it 'returns the xp a player needs to reach next level' do
      expect(result).to have_key('player_xp_needed_to_level_up')
    end
  end

  describe '.community_badge_progress' do
    let(:result) { described_class.community_badge_progress(playerid) }

    it 'allows a user to retrieve community badge info for a player' do
      expect(result).not_to be_nil
    end

    it 'returns a list of quests' do
      expect(result).to be_a(Array)
    end

    it 'returns a list of quests with ids and completion status' do
      expect(result.first).to match 'questid' => a_kind_of(Integer), 'completed' => boolean
    end
  end
end
