require 'spec_helper'

describe Steam::Inventory do
  let(:playerid) { 76561197993276293 }

  describe '.get_inventory' do
    let(:result) { Steam::Inventory.get_inventory(playerid) }
    
    it 'returns data' do
      expect(result).to_not be_nil
    end

    it 'returns list of player\'s inventory' do
      expect(result.class).to eq(Array)
    end
  end
end