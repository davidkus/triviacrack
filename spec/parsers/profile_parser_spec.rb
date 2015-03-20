require "spec_helper"

describe TriviaCrack::Parsers::ProfileParser do

  describe ".parse" do

    subject { TriviaCrack::Parsers::ProfileParser.parse raw_data }

    context 'when given data from the profile API' do
      let(:raw_data) { SpecData.get "profile.json" }

      it { is_expected.to be_a TriviaCrack::Profile }
      its(:id) { is_expected.to be 111 }
      its(:is_friend) { is_expected.to be false }
      its(:is_blocked) { is_expected.to be false }
      its(:username) { is_expected.to eq "example" }
      its(:country) { is_expected.to be :us }
      its(:email) { is_expected.to eq "user@example.com" }
      its(:last_play) { is_expected.to be_a Time }
      its(:last_login) { is_expected.to be_a Time }
      its(:games_won) { is_expected.to be 530 }
      its(:games_lost) { is_expected.to be 240 }
      its(:games_resigned) { is_expected.to be 0 }
      its(:consecutive_games_won) { is_expected.to be 3 }
      its(:consecutive_answers_correct) { is_expected.to be 0 }
      its(:level) { is_expected.to be 167 }
      its(:challenges_won) { is_expected.to be 35 }
      its(:challenges_lost) { is_expected.to be 6 }
      its('categories.count') { is_expected.to eq 6 }
      its(:my_wins_vs_user) { is_expected.to be 0 }
      its(:my_losses_vs_user) { is_expected.to be 1 }
    end

    context 'when given data from the current user profile API' do
      let(:raw_data) { SpecData.get "my_profile.json" }

      it { is_expected.to be_a TriviaCrack::Profile }
      its(:id) { is_expected.to be 222 }
      its(:is_friend) { is_expected.to be false }
      its(:is_blocked) { is_expected.to be false }
      its(:username) { is_expected.to eq "example2" }
      its(:country) { is_expected.to be :ca }
      its(:email) { is_expected.to eq "user2@example.com" }
      its(:last_play) { is_expected.to be_a Time }
      its(:last_login) { is_expected.to be_a Time }
      its(:games_won) { is_expected.to be 37 }
      its(:games_lost) { is_expected.to be 12 }
      its(:games_resigned) { is_expected.to be 0 }
      its(:consecutive_games_won) { is_expected.to be 0 }
      its(:consecutive_answers_correct) { is_expected.to be 12 }
      its(:level) { is_expected.to be 42 }
      its(:challenges_won) { is_expected.to be 4 }
      its(:challenges_lost) { is_expected.to be 0 }
      its('categories.count') { is_expected.to eq 6 }
      its(:my_wins_vs_user) { is_expected.to be nil }
      its(:my_losses_vs_user) { is_expected.to be nil }
    end
  end
end
