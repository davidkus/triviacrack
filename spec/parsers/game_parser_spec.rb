require "spec_helper"

describe TriviaCrack::Parsers::GameParser do

  describe ".parse" do

    let(:game_data) { SpecData.get "game.json" }
    let(:dashboard_data) { SpecData.get "dashboard.json" }
    let(:answer_data) { SpecData.get "answer.json" }

    it "should parse raw data from games API" do
      game = TriviaCrack::Parsers::GameParser.parse game_data

      expect(game.id).to eq(1111)
      expect(game.language).to eq("EN")
      expect(game.my_turn).to eq(true)
      expect(game.game_status).to eq("ACTIVE")
      expect(game.questions.size).to eq(1)
      expect(game.round_number).to eq(4)
      expect(game.opponent.username).to eq("example.2")
    end

    it "should parse raw data from dashboard API" do
      game = TriviaCrack::Parsers::GameParser.parse dashboard_data["list"][3]

      expect(game.id).to eq(1115)
      expect(game.language).to eq("EN")
      expect(game.my_turn).to eq(true)
      expect(game.game_status).to eq("ACTIVE")
      expect(game.questions.size).to eq(1)
      expect(game.questions.first.id).to eq(15593975)
      expect(game.round_number).to eq(4)
      expect(game.opponent.username).to eq("example.6")
    end

    it "should parse raw data from the answers API" do
      game = TriviaCrack::Parsers::GameParser.parse answer_data

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
