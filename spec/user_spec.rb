require_relative "spec_helper"

describe TriviaCrack::User do
  describe "#start_new_game?" do
    it "should return true if user has one or more lives" do
      user = TriviaCrack::User.new id: 111, lives: 1, unlimited_lives: false

      expect(user.start_new_game?).to be(true)
    end

    it "should return true if user has unlimited lives" do
      user = TriviaCrack::User.new id: 111, lives: 0, unlimited_lives: true

      expect(user.start_new_game?).to be(true)
    end

    it "should return false if user has no more lives" do
      user = TriviaCrack::User.new id: 111, lives: 0, unlimited_lives: false

      expect(user.start_new_game?).to be(false)
    end
  end

  describe ".from" do
    it "should parse raw data correctly" do
      dashboard_data = SpecData.get "user.json"
      user_id = 111

      user = TriviaCrack::User.from dashboard_data

      expect(user.coins).to eq(111)
      expect(user.lives).to eq(3)
      expect(user.unlimited_lives).to eq(false)
      expect(user.level).to eq(31)
      expect(user.level_progress).to eq(63)
      expect(user.username).to eq("example")
    end
  end
end
