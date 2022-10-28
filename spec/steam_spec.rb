# frozen_string_literal: true

describe Steam do
  describe '.apikey' do
    subject(:apikey) { described_class.apikey }

    it { is_expected.not_to be_nil }

    context 'when `nil`' do
      before do
        described_class.apikey = nil
        ENV['STEAM_API_KEY'] = nil
      end

      specify do
        expect { apikey }.to raise_error(ArgumentError, /Please set your Steam API key/)
      end
    end

    context 'when set using ENV' do
      let(:new_apikey) { 'blah' }

      before do
        described_class.apikey = nil
        ENV['STEAM_API_KEY'] = new_apikey
      end

      it { is_expected.to eq new_apikey }
    end
  end

  describe '.apikey=' do
    subject(:apikey) { described_class.apikey }

    let(:new_apikey) { 'blah' }

    before do
      described_class.apikey = new_apikey
    end

    it { is_expected.to eq new_apikey }
  end
end
