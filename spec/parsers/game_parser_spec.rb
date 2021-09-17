require "spec_helper"

describe TriviaCrack::Parsers::GameParser do

  describe ".parse" do

    subject { TriviaCrack::Parsers::GameParser.parse raw_data }

    let(:game_data) { SpecData.get_json "game.json" }
    let(:dashboard_data) { SpecData.get_json "dashboard.json" }
    let(:answer_data) { SpecData.get_json "answer.json" }
    let(:new_game_data) { SpecData.get_json "new_game.json" }

    context 'when given data from the games API' do
      let(:raw_data) { SpecData.get_json "game.json" }

      it { is_expected.to be_a TriviaCrack::Game }
      its(:id) { is_expected.to be 1111 }
      its(:opponent) { is_expected.to be_a TriviaCrack::User }
      its('opponent.id') { is_expected.to be 111 }
      its(:game_status) { is_expected.to be :active }
      its(:language) { is_expected.to be :en }
      its(:created) { is_expected.to be_a Time }
      its(:last_turn) { is_expected.to be_a Time }
      its(:type) { is_expected.to be :normal }
      its(:expiration_date) { is_expected.to be_a Time }
      its(:my_turn) { is_expected.to be true }
      its(:round_number) { is_expected.to be 4 }
      its(:is_random) { is_expected.to be true }
      its(:unread_messages) { is_expected.to be 0 }
      its(:status_version) { is_expected.to be 23 }
      its(:available_crowns) { is_expected.to contain_exactly(:entertainment, :arts, :sports) }
      its('questions.first') { is_expected.to be_a TriviaCrack::Question }
      its('questions.first.id') { is_expected.to be 16653413 }
      its(:my_statistics) { is_expected.to be_a TriviaCrack::GameStatistics }
      its(:opponent_statistics) { is_expected.to be_a TriviaCrack::GameStatistics }
    end

    context 'when given data from the dashboard API' do
      let(:raw_data) { SpecData.get_json("dashboard.json")["list"][3] }

      it { is_expected.to be_a TriviaCrack::Game }
      its(:id) { is_expected.to be 1115 }
      its(:opponent) { is_expected.to be_a TriviaCrack::User }
      its('opponent.id') { is_expected.to be 114 }
      its(:game_status) { is_expected.to be :active }
      its(:language) { is_expected.to be :en }
      its(:created) { is_expected.to be_a Time }
      its(:last_turn) { is_expected.to be_a Time }
      its(:type) { is_expected.to be :normal }
      its(:expiration_date) { is_expected.to be_a Time }
      its(:my_turn) { is_expected.to be true }
      its(:round_number) { is_expected.to be 4 }
      its(:is_random) { is_expected.to be true }
      its(:unread_messages) { is_expected.to be 0 }
      its(:status_version) { is_expected.to be 24 }
      its(:available_crowns) { is_expected.to contain_exactly(:entertainment, :arts, :sports) }
      its('questions.first') { is_expected.to be_a TriviaCrack::Question }
      its('questions.first.id') { is_expected.to be 15593975 }
      its(:my_statistics) { is_expected.to be_a TriviaCrack::GameStatistics }
      its(:opponent_statistics) { is_expected.to be_a TriviaCrack::GameStatistics }
    end

    context 'when given data from the answers API' do
      let(:raw_data) { SpecData.get_json "answer.json" }

      it { is_expected.to be_a TriviaCrack::Game }
      its(:id) { is_expected.to be 1111 }
      its(:opponent) { is_expected.to be_a TriviaCrack::User }
      its('opponent.id') { is_expected.to be 111 }
      its(:game_status) { is_expected.to be :active }
      its(:language) { is_expected.to be :en }
      its(:created) { is_expected.to be_a Time }
      its(:last_turn) { is_expected.to be_a Time }
      its(:type) { is_expected.to be :normal }
      its(:expiration_date) { is_expected.to be_a Time }
      its(:my_turn) { is_expected.to be true }
      its(:round_number) { is_expected.to be 4 }
      its(:is_random) { is_expected.to be true }
      its(:unread_messages) { is_expected.to be 0 }
      its(:status_version) { is_expected.to be 24 }
      its(:available_crowns) { is_expected.to contain_exactly(:entertainment, :arts, :sports) }
      its('questions.first') { is_expected.to be_a TriviaCrack::Question }
      its('questions.first.id') { is_expected.to be 15593975 }
      its(:my_statistics) { is_expected.to be_a TriviaCrack::GameStatistics }
      its(:opponent_statistics) { is_expected.to be_a TriviaCrack::GameStatistics }
    end

    context 'when given data from the new game API' do
      let(:raw_data) { SpecData.get_json "new_game.json" }

      it { is_expected.to be_a TriviaCrack::Game }
      its(:id) { is_expected.to be 2222 }
      its(:opponent) { is_expected.to be_a TriviaCrack::User }
      its('opponent.id') { is_expected.to be 0 }
      its(:game_status) { is_expected.to be :pending_approval }
      its(:language) { is_expected.to be :en }
      its(:created) { is_expected.to be_a Time }
      its(:last_turn) { is_expected.to be_a Time }
      its(:type) { is_expected.to be :normal }
      its(:expiration_date) { is_expected.to be_a Time }
      its(:my_turn) { is_expected.to be true }
      its(:round_number) { is_expected.to be 1 }
      its(:is_random) { is_expected.to be true }
      its(:unread_messages) { is_expected.to be 0 }
      its(:status_version) { is_expected.to be 0 }
      its(:available_crowns) { is_expected.to contain_exactly(:arts, :entertainment, :geography, :history, :science, :sports) }
      its('questions.first') { is_expected.to be_a TriviaCrack::Question }
      its('questions.first.id') { is_expected.to be 12785 }
      its(:my_statistics) { is_expected.to be_a TriviaCrack::GameStatistics }
      its(:opponent_statistics) { is_expected.to be_a TriviaCrack::GameStatistics }
    end

    context 'when given data from the games API and the game is a duel' do
      let(:raw_data) { SpecData.get_json "game_duel.json" }

      it { is_expected.to be_a TriviaCrack::Game }
      its(:id) { is_expected.to be 1119 }
      its(:opponent) { is_expected.to be_a TriviaCrack::User }
      its('opponent.id') { is_expected.to be 321 }
      its(:game_status) { is_expected.to be :active }
      its(:language) { is_expected.to be :en }
      its(:created) { is_expected.to be_a Time }
      its(:last_turn) { is_expected.to be_a Time }
      its(:type) { is_expected.to be :normal }
      its(:expiration_date) { is_expected.to be_a Time }
      its(:my_turn) { is_expected.to be true }
      its(:round_number) { is_expected.to be 2 }
      its(:is_random) { is_expected.to be true }
      its(:unread_messages) { is_expected.to be 0 }
      its(:status_version) { is_expected.to be 13 }
      its(:available_crowns) { is_expected.to contain_exactly(:entertainment, :science, :history, :sports) }
      its('questions.size') { is_expected.to eq(7) }
      its('questions.first') { is_expected.to be_a TriviaCrack::Question }
      its('questions.first.id') { is_expected.to be 17881223 }
      its(:my_statistics) { is_expected.to be_a TriviaCrack::GameStatistics }
      its(:opponent_statistics) { is_expected.to be_a TriviaCrack::GameStatistics }
    end
  end
end
