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

  describe ".from" do
    it "should parse raw data from games API" do
      game_data = SpecData.get "game.json"

      game = TriviaCrack::Game.from game_data

      expect(game.id).to eq(1111)
      expect(game.language).to eq("EN")
      expect(game.my_turn).to eq(true)
      expect(game.game_status).to eq("ACTIVE")
      expect(game.questions.size).to eq(1)
      expect(game.round_number).to eq(4)
      expect(game.opponent.username).to eq("example.2")
    end

    it "should parse raw data from dashboard API" do
      dashboard_data = SpecData.get "dashboard.json"

      game_data = dashboard_data["list"][0]

      game = TriviaCrack::Game.from game_data

      expect(game.id).to eq(1111)
      expect(game.language).to eq("EN")
      expect(game.my_turn).to eq(false)
      expect(game.game_status).to eq("ACTIVE")
      expect(game.questions.size).to eq(0)
      expect(game.round_number).to eq(4)
      expect(game.opponent.username).to eq("example.2")
    end

    it "should parse raw data from the answers API" do
      answer_data = SpecData.get "answer.json"

      game = TriviaCrack::Game.from answer_data

      expect(game.id).to eq(1111)
      expect(game.language).to eq("EN")
      expect(game.my_turn).to eq(true)
      expect(game.game_status).to eq("ACTIVE")
      expect(game.questions.size).to eq(1)
      expect(game.round_number).to eq(4)
      expect(game.opponent.username).to eq("example.2")
    end
  end
end
