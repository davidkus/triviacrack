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

end
