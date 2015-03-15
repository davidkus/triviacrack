require "spec_helper"

describe TriviaCrack::Parsers::UserParser do

  describe ".parse" do

    let(:user_data) { SpecData.get "user.json" }
    let(:user_id) { 111 }

    it "should parse raw data correctly" do
      user = TriviaCrack::Parsers::UserParser.parse user_data

      expect(user.coins).to eq(111)
      expect(user.lives).to eq(3)
      expect(user.unlimited_lives).to eq(false)
      expect(user.country).to eq(:ca)
      expect(user.level).to eq(31)
      expect(user.level_progress).to eq(63)
      expect(user.username).to eq("example")
    end
  end

end
