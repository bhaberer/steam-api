require 'spec_helper'

describe Steam::UserStats do
  describe '.achievement_percentages' do
    it 'should return achievement information' do
      Steam::UserStats.achievement_percentages(440)
        .should_not be_nil
    end

    it 'should return all achievements for a game' do
      achs = Steam::UserStats.achievement_percentages(440)
      achs.first.should have_key('name')
      achs.first.should have_key('percent')
    end
  end

  describe '.game_schema' do
    it 'should return global game stats' do
      Steam::UserStats.game_schema(440)
        .should_not be_nil
    end

    it 'should return global game stats with proper schema' do
      Steam::UserStats.game_schema(440)
        .should have_key('gameName')
    end

    it 'should return global game stats with proper schema' do
      Steam::UserStats.game_schema(440)
        .should have_key('gameName')
    end

    it 'should return global game stats with proper schema' do
      Steam::UserStats.game_schema(440)
        .should have_key('gameVersion')
    end

    it 'should return global game stats with proper schema' do
      Steam::UserStats.game_schema(440)
        .should have_key('availableGameStats')
    end
  end

  describe '.global_for_game' do
    it 'should return global game stats' do
      Steam::UserStats.global_for_game(201830,
                                       params: { 'name[0]' => 'totalDeaths',
                                                 count: 10 })
    end
  end

  describe '.player_count' do
    it 'should return a player count' do
      Steam::UserStats.player_count(440)
        .should be_a(Fixnum)
    end
  end

  describe '.get_player_achievements' do
    it 'should return player achievements' do
      Steam::UserStats.player_achievements(440, 76561197969622382)
        .should have_key('achievements')
    end

    it 'should return player achievements' do
      Steam::UserStats.player_achievements(440, 76561197969622382)
        .should have_key('gameName')
    end

    it 'should return player achievements' do
      Steam::UserStats.player_achievements(440, 76561197969622382)['gameName']
        .should == 'Team Fortress 2'
    end

    it 'should return player achievements' do
      Steam::UserStats.player_achievements(440, 76561197969622382)
        .should have_key('steamID')
    end

    it 'should return player achievements' do
      Steam::UserStats.player_achievements(440, 76561197969622382)['steamID']
        .should == '76561197969622382'
    end
  end
end
