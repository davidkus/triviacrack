require_relative "spec_helper"

describe TriviaCrack::Game do

  describe "#playable?" do

    it "should return true when game is ACTIVE and it is user's turn" do
      game = TriviaCrack::Game.new id: 1111, my_turn: true,
                                   game_status: "ACTIVE"

      expect(game.playable?).to eq(true)
    end

    it "should return true when game is PENDING_APPROVAL" do
      game = TriviaCrack::Game.new id: 1111, my_turn: true,
                                   game_status: "PENDING_APPROVAL"

      expect(game.playable?).to eq(true)
    end

    it "should return false when game is not ACTIVE" do
      game = TriviaCrack::Game.new id: 1111, my_turn: true,
                                   game_status: "ENDED"

      expect(game.playable?).to eq(false)
    end

    it "should return false when it is not user's turn" do
      game = TriviaCrack::Game.new id: 1111, my_turn: false,
                                   game_status: "ACTIVE"

      expect(game.playable?).to eq(false)
    end
  end

end
