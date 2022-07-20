# frozen_string_literal: true

require 'spec_helper'

describe TriviaCrack::Parsers::CategoryStatisticsParser do
  describe '.parse' do
    subject { TriviaCrack::Parsers::CategoryStatisticsParser.parse(category_data).values.first }

    let(:category_data) { raw_data['statistics']['player_one_statistics']['category_questions'] }

    context 'when given data from the games API' do
      let(:raw_data) { SpecData.get_json 'game.json' }

      it { is_expected.to be_a TriviaCrack::CategoryStatistics }
      its(:category) { is_expected.to be :geography }
      its(:correct) { is_expected.to be 2 }
      its(:incorrect) { is_expected.to be 1 }
      its(:worst) { is_expected.to be false }
    end

    context 'when given data from the dashboard API' do
      let(:raw_data) { SpecData.get_json('dashboard.json')['list'][3] }

      it { is_expected.to be_a TriviaCrack::CategoryStatistics }
      its(:category) { is_expected.to eq :arts }
      its(:correct) { is_expected.to be 3 }
      its(:incorrect) { is_expected.to be 0 }
      its(:worst) { is_expected.to be false }
    end

    context 'when given data from the answers API' do
      let(:raw_data) { SpecData.get_json 'answer.json' }

      it { is_expected.to be_a TriviaCrack::CategoryStatistics }
      its(:category) { is_expected.to eq :sports }
      its(:correct) { is_expected.to be 1 }
      its(:incorrect) { is_expected.to be 0 }
      its(:worst) { is_expected.to be false }
    end
  end
end
