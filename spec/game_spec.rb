require_relative "spec_helper"

describe TriviaCrack::Game do

  let(:game_id) { 1111 }
  let(:game) { TriviaCrack::Game.new id: game_id, my_turn: my_turn, game_status: game_status }

  describe "#playable?" do

    subject { game.playable? }

    context 'when the game status is active' do
      let(:game_status) { :active }

      context 'and it is the users turn' do
        let(:my_turn) { true }

        it { is_expected.to be true }
      end

      context 'and it is not the users turn' do
        let(:my_turn) { false }

        it { is_expected.to be false }
      end
    end

    context 'when the game status is pending_approval' do
      let(:game_status) { :pending_approval }

      context 'and it is the users turn' do
        let(:my_turn) { true }

        it { is_expected.to be true }
      end

      context 'and it is not the users turn' do
        let(:my_turn) { false }

        it { is_expected.to be false }
      end
    end

    context 'when the game status is ended' do
      let(:game_status) { :ended }

      context 'and it is the users turn' do
        let(:my_turn) { true }

        it { is_expected.to be false }
      end

      context 'and it is not the users turn' do
        let(:my_turn) { false }

        it { is_expected.to be false }
      end
    end
  end
end
