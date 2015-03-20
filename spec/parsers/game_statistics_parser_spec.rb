require "spec_helper"

describe TriviaCrack::Parsers::GameStatisticsParser do

  describe ".parse" do

    subject { TriviaCrack::Parsers::GameStatisticsParser.parse statistics_data }

    let(:statistics_data) { raw_data["statistics"]["player_one_statistics"] }
    before { statistics_data["crowns"] = raw_data["player_one"]["crowns"] }

    context 'when given data from the games API' do
      let(:raw_data) { SpecData.get "game.json" }

      it { is_expected.to be_a TriviaCrack::GameStatistics }
      its(:correct_answers) { is_expected.to be 12 }
      its(:incorrect_answers) { is_expected.to be 3 }
      its(:challenges_won) { is_expected.to be 0 }
      its(:questions_answered) { is_expected.to be 15 }
      its(:crowns) { is_expected.to contain_exactly :history, :science, :geography }
    end

    context 'when given data from the dashboard API' do
      let(:raw_data) { SpecData.get("dashboard.json")["list"][3] }

      it { is_expected.to be_a TriviaCrack::GameStatistics }
      its(:correct_answers) { is_expected.to be 13 }
      its(:incorrect_answers) { is_expected.to be 3 }
      its(:challenges_won) { is_expected.to be 0 }
      its(:questions_answered) { is_expected.to be 16 }
      its(:crowns) { is_expected.to contain_exactly :history, :science, :geography }
    end

    context 'when given data from the answer API' do
      let(:raw_data) { SpecData.get "answer.json" }

      it { is_expected.to be_a TriviaCrack::GameStatistics }
      its(:correct_answers) { is_expected.to be 13 }
      its(:incorrect_answers) { is_expected.to be 3 }
      its(:challenges_won) { is_expected.to be 0 }
      its(:questions_answered) { is_expected.to be 16 }
      its(:crowns) { is_expected.to contain_exactly :history, :science, :geography }
    end

    context 'when given data from the new game API' do
      let(:raw_data) { SpecData.get "new_game.json" }

      it { is_expected.to be_a TriviaCrack::GameStatistics }
      its(:correct_answers) { is_expected.to be 0 }
      its(:incorrect_answers) { is_expected.to be 0 }
      its(:challenges_won) { is_expected.to be 0 }
      its(:questions_answered) { is_expected.to be 0 }
      its(:crowns) { is_expected.to be_empty}
    end
  end
end
