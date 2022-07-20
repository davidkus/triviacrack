# frozen_string_literal: true

require 'spec_helper'

describe TriviaCrack::Parsers::SessionParser do
  describe '.parse' do
    subject { TriviaCrack::Parsers::SessionParser.parse raw_data }

    context 'when given data from the login API' do
      let(:raw_data) { SpecData.get_json 'login.json' }

      it { is_expected.to be_a TriviaCrack::Session }
      its(:user_id) { is_expected.to be 111 }
      its(:username) { is_expected.to eq 'example' }
      its(:session_id) { is_expected.to eq 'session123' }
      its(:device_key) { is_expected.to eq 'device123' }
      its(:expiration) { is_expected.to be_a Time }
    end
  end
end
