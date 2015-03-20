require "spec_helper"

describe TriviaCrack::Parsers::QuestionParser do

  describe ".parse" do

    subject { TriviaCrack::Parsers::QuestionParser.parse raw_data }

    context 'when given data without an image' do
      let(:raw_data) { SpecData.get "question.json" }

      it { is_expected.to be_a TriviaCrack::Question }
      its(:type) { is_expected.to be :normal }
      its(:media_type) { is_expected.to be :normal }
      its(:text) { is_expected.to eq "Who recorded this album?" }
      its(:correct_answer) { is_expected.to be 3 }
      its(:category) { is_expected.to be :entertainment }
      its(:answers) { is_expected.to contain_exactly "Creedence Cleawater Revival", "Bob Marley", "blink-182", "Jimmy Hendrix" }
    end

    context 'when given data with an image' do
      let(:raw_data) { SpecData.get "question_image.json" }

      it { is_expected.to be_a TriviaCrack::Question }
      its(:type) { is_expected.to be :normal }
      its(:media_type) { is_expected.to be :image }
      its(:text) { is_expected.to eq "Who recorded this album?" }
      its(:correct_answer) { is_expected.to be 3 }
      its(:category) { is_expected.to be :entertainment }
      its(:image_url) { is_expected.to eq "http://qimg.preguntados.com/ENT_3028" }
      its(:answers) { is_expected.to contain_exactly "Creedence Cleawater Revival", "Bob Marley", "blink-182", "Jimmy Hendrix" }
    end
  end
end
