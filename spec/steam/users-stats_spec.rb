require 'spec_helper'

describe Steam::UserStats do
  describe '.achievement_percentages' do
    it 'should return achievement information' do
      expect(Steam::UserStats.achievement_percentages(440))
        .to_not be_nil
    end

    it 'should return all achievements for a game' do
      achs = Steam::UserStats.achievement_percentages(440)
      expect(achs.first).to have_key('name')
      expect(achs.first).to have_key('percent')
    end
  end

  describe '.game_schema' do
    it 'should return global game stats' do
      expect(Steam::UserStats.game_schema(440))
        .to_not be_nil
    end

    it 'should return global game stats with proper schema' do
      expect(Steam::UserStats.game_schema(440))
        .to have_key('gameName')
    end

    it 'should return global game stats with proper schema' do
      expect(Steam::UserStats.game_schema(440))
        .to have_key('gameName')
    end

    it 'should return global game stats with proper schema' do
      expect(Steam::UserStats.game_schema(440))
        .to have_key('gameVersion')
    end

    it 'should return global game stats with proper schema' do
      expect(Steam::UserStats.game_schema(440))
        .to have_key('availableGameStats')
    end
  end

  describe '.global_for_game' do
    it 'should return global game stats' do
      expect(Steam::UserStats.global_for_game(201830,
                                       params: { 'name[0]' => 'totalDeaths',
                                                 count: 10 }))
    end
  end

  describe '.player_count' do
    it 'should return a player count' do
      expect(Steam::UserStats.player_count(440))
        .to be_a(Fixnum)
    end
  end

  describe '.get_player_achievements' do
    before(:each) do
      @achs = Steam::UserStats.player_achievements(440, 76561197969622382)
    end

    it 'should return player achievements' do
      expect(@achs)
        .to have_key('achievements')
    end

    it 'should return player achievements' do
      expect(@achs)
        .to have_key('gameName')
    end

    it 'should return player achievements' do
      expect(@achs['gameName'])
        .to eq('Team Fortress 2')
    end

    it 'should return player achievements' do
      expect(Steam::UserStats.player_achievements(440, 76561197969622382))
        .to have_key('steamID')
    end

    it 'should return player achievements' do
      expect(Steam::UserStats.player_achievements(440, 76561197969622382)['steamID'])
        .to eq('76561197969622382')
    end
  end
end
