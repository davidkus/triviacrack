# frozen_string_literal: true

require_relative 'spec_helper'

describe TriviaCrack::User do
  let(:user_id) { 111 }
  let(:user) { TriviaCrack::User.new id: user_id, lives: lives, unlimited_lives: unlimited_lives }

  describe '#start_new_game?' do
    subject { user.start_new_game? }

    context 'when the user has one or more live' do
      let(:lives) { 1 }
      let(:unlimited_lives) { false }

      it { is_expected.to be true }
    end

    context 'when the user has unlimited lives' do
      let(:lives) { 0 }
      let(:unlimited_lives) { true }

      it { is_expected.to be true }
    end

    context 'when the user has no more lives' do
      let(:lives) { 0 }
      let(:unlimited_lives) { false }

      it { is_expected.to be false }
    end
  end
end
