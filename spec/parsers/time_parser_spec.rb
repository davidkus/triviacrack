require "spec_helper"

describe TriviaCrack::Parsers::TimeParser do

  describe ".parse" do

    subject { TriviaCrack::Parsers::TimeParser.parse raw_data }

    let(:raw_data) { "02/18/2015 00:11:33 EST" }

    it { is_expected.to be_a Time }
    its(:day) { is_expected.to be 18 }
    its(:month) { is_expected.to be 2 }
    its(:year) { is_expected.to be 2015 }
    its(:hour) { is_expected.to be 0 }
    its(:min) { is_expected.to be 11 }
    its(:sec) { is_expected.to be 33 }
  end
end
