require "spec_helper"

describe TriviaCrack::Parsers::UserParser do

  describe ".parse" do

    subject { TriviaCrack::Parsers::UserParser.parse raw_data }

    context 'when given data from the user API' do
      let(:raw_data) { SpecData.get_json "user.json" }

      it { is_expected.to be_a TriviaCrack::User }
      its(:id) { is_expected.to be 111 }
      its(:username) { is_expected.to eq "example" }
      its(:facebook_id) { is_expected.to eq "1" }
      its(:facebook_name) { is_expected.to eq "Example Name" }
      its(:coins) { is_expected.to be 111 }
      its(:lives) { is_expected.to be 3 }
      its(:max_lives) { is_expected.to be 3 }
      its(:unlimited_lives) { is_expected.to be false }
      its(:country) { is_expected.to be :ca }
      its(:extra_shots) { is_expected.to be 3 }
      its(:level) { is_expected.to be 31 }
      its(:level_points) { is_expected.to be 546 }
      its(:level_progress) { is_expected.to be 63 }
      its(:goal_points) { is_expected.to be 558 }
      its(:level_up) { is_expected.to be false }
    end

    context 'when given opponent data from the game API' do
      let(:raw_data) { SpecData.get_json("game.json")["opponent"] }

      it { is_expected.to be_a TriviaCrack::User }
      its(:id) { is_expected.to be 111 }
      its(:username) { is_expected.to eq "example.2" }
      its(:facebook_id) { is_expected.to eq "" }
      its(:facebook_name) { is_expected.to be nil }
      its(:coins) { is_expected.to be nil }
      its(:lives) { is_expected.to be nil }
      its(:max_lives) { is_expected.to be nil }
      its(:unlimited_lives) { is_expected.to be nil }
      its(:country) { is_expected.to be nil }
      its(:extra_shots) { is_expected.to be nil }
      its(:level) { is_expected.to be 116 }
      its(:level_points) { is_expected.to be nil }
      its(:level_progress) { is_expected.to be nil }
      its(:goal_points) { is_expected.to be nil }
      its(:level_up) { is_expected.to be nil }
    end
  end
end
