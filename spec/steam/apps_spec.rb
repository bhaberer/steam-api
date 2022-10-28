# frozen_string_literal: true

describe Steam::Apps do
  describe '.get_all' do
    let(:result) { Steam::Apps.get_all }

    it 'returns a list of apps' do
      expect(result).to_not be_nil
    end

    it 'returns an appid for each game' do
      expect(result.first).to have_key 'appid'
    end

    it 'returns a name for each game' do
      expect(result.first).to have_key 'name'
    end
  end

  describe '.get_servers' do
    let(:result) { Steam::Apps.get_servers(addr: '192.168.1.1') }

    it 'returns a valid response' do
      expect(result).to_not be_nil
    end

    it 'returns an empty array for an ip with no servers' do
      expect(result).to eq([])
    end
  end

  describe '.up_to_date' do
    context 'when looking up out of date version info' do
      let(:result) { Steam::Apps.up_to_date(appid: 440, version: 10) }

      it 'does not return a nil response' do
        expect(result).to_not be_nil
      end

      it "returns a false value for 'up_to_date'" do
        expect(result['up_to_date']).to be_falsey
      end

      it "returns a false value for 'version_is_listable'" do
        expect(result['version_is_listable']).to be_falsey
      end

      it 'returns a required_version' do
        expect(result).to have_key('required_version')
      end

      it 'returns an error message' do
        expect(result['message']).to eq('Your server is out of date, please upgrade')
      end
    end

    context 'when looking up current version info' do
      let(:current) { Steam::Apps.up_to_date(appid: 440, version: 10)['required_version'] }
      let(:check) { Steam::Apps.up_to_date(appid: 440, version: current) }

      it 'returns a positive up to date value' do
        expect(check['up_to_date']).to be_truthy
      end

      it 'returns a positive version_is_listable value' do
        expect(check['version_is_listable']).to be_truthy
      end
    end

    it 'should capture json errors' do
      expect { Steam::Apps.up_to_date(appid: nil, version: 'foo') }.to raise_error(Steam::JSONError)
    end
  end
end
