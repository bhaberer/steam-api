# frozen_string_literal: true

describe Steam::UserStats do
  describe '.achievement_percentages' do
    let(:result) { described_class.achievement_percentages(440) }

    it 'returns achievement information' do
      expect(result).not_to be_nil
    end

    it 'returns all achievements for a game' do
      expect(result.first).to match 'name' => a_kind_of(String), 'percent' => a_kind_of(Numeric)
    end
  end

  describe '.game_schema' do
    let(:result) { described_class.game_schema(440) }

    it 'returns global game stats' do
      expect(result).not_to be_nil
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
    subject do
      ## https://stackoverflow.com/a/35650119/2630849
      ## https://stackoverflow.com/q/57750281/2630849
      ## Sadly, it seems that Steam closed (by default?) all the aggregated stats
      described_class.global_for_game(
        '779340', params: { 'name[0]' => 'TOTAL_PLAY_TIME', count: 1 }
      )
    end

    let(:expected_result) do
      {
        'error' => "Stat 'TOTAL_PLAY_TIME' is not an aggregated stat",
        'result' => 8
      }
    end

    it { is_expected.to eq expected_result }
  end

  describe '.player_count' do
    it 'returns a player count' do
      expect(described_class.player_count(440)).to be_a(Integer)
    end
  end

  describe '.get_player_achievements' do
    let(:achs) do
      described_class.player_achievements(440, '76561197993276293')
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
    let(:stats) { described_class.player_stats(440, '76561197993276293') }

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
