# frozen_string_literal: true

require 'spec_helper'

describe Steam::UserStats do
  describe '.achievement_percentages' do
    let(:result) { Steam::UserStats.achievement_percentages(440) }

    it 'returns achievement information' do
      expect(result).to_not be_nil
    end

    it 'returns all achievements for a game' do
      expect(result.first).to have_key('name')
      expect(result.first).to have_key('percent')
    end
  end

  describe '.game_schema' do
    let(:result) { Steam::UserStats.game_schema(440) }

    it 'returns global game stats' do
      expect(result).to_not be_nil
    end

    it 'returns global game stats with a gameName' do
      expect(result).to have_key('gameName')
    end

    it 'returns global game stats with a gameVersion' do
      expect(result).to have_key('gameVersion')
    end

    it 'returns global game stats with availableGameStats' do
      expect(result).to have_key('availableGameStats')
    end
  end

  describe '.global_for_game' do
    it 'returns global game stats' do
      Steam::UserStats.global_for_game('201830', params: { 'name[0]' => 'totalDeaths', count: 10 })
    end
  end

  describe '.player_count' do
    it 'returns a player count' do
      expect(Steam::UserStats.player_count(440)).to be_a(Integer)
    end
  end

  describe '.get_player_achievements' do
    let(:achs) do
      Steam::UserStats.player_achievements(440, '76561197993276293')
    end

    it 'returns a list of player achievements' do
      expect(achs).to have_key('achievements')
    end

    it 'returns a gameName' do
      expect(achs).to have_key('gameName')
    end

    it 'returns correct gameName' do
      expect(achs['gameName']).to eq('Team Fortress 2')
    end

    it 'returns a steamID' do
      expect(achs).to have_key('steamID')
    end

    it 'returns the correct steamID' do
      expect(achs['steamID']).to eq('76561197993276293')
    end
  end

  describe '.player_stats' do
    let(:stats) { Steam::UserStats.player_stats(440, '76561197993276293') }

    it 'returns player stats' do
      expect(stats).to have_key('stats')
    end

    it 'returns a gameName' do
      expect(stats).to have_key('gameName')
    end

    it 'returns the correct gameName' do
      expect(stats['gameName']).to eq('Team Fortress 2')
    end

    it 'returns a steamID' do
      expect(stats).to have_key('steamID')
    end

    it 'returns a correct steamID' do
      expect(stats['steamID']).to eq('76561197993276293')
    end
  end
end
