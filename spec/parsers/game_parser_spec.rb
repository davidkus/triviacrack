require "spec_helper"

describe TriviaCrack::Parsers::GameParser do

  describe ".parse" do

    let(:game_data) { SpecData.get "game.json" }
    let(:dashboard_data) { SpecData.get "dashboard.json" }
    let(:answer_data) { SpecData.get "answer.json" }
    let(:new_game_data) { SpecData.get "new_game.json" }

    it "should parse raw data from games API" do
      game = TriviaCrack::Parsers::GameParser.parse game_data

      expect(game.id).to eq(1111)
      expect(game.type).to eq(:normal)
      expect(game.language).to eq(:en)
      expect(game.my_turn).to eq(true)
      expect(game.game_status).to eq(:active)
      expect(game.questions.size).to eq(1)
      expect(game.round_number).to eq(4)
      expect(game.opponent.username).to eq("example.2")
      expect(game.my_statistics).to_not be_nil
      expect(game.my_statistics.crowns.count).to eq(3)
      expect(game.opponent_statistics).to_not be_nil
      expect(game.opponent_statistics.crowns.count).to eq(1)
    end

    it "should parse raw data from dashboard API" do
      game = TriviaCrack::Parsers::GameParser.parse dashboard_data["list"][3]

      expect(game.id).to eq(1115)
      expect(game.language).to eq(:en)
      expect(game.my_turn).to eq(true)
      expect(game.game_status).to eq(:active)
      expect(game.questions.size).to eq(1)
      expect(game.questions.first.id).to eq(15593975)
      expect(game.round_number).to eq(4)
      expect(game.opponent.username).to eq("example.6")
      expect(game.my_statistics).to_not be_nil
      expect(game.my_statistics.crowns.count).to eq(3)
      expect(game.opponent_statistics).to_not be_nil
      expect(game.opponent_statistics.crowns.count).to eq(1)
    end

    it "should parse raw data from the answers API" do
      game = TriviaCrack::Parsers::GameParser.parse answer_data

      expect(game.id).to eq(1111)
      expect(game.language).to eq(:en)
      expect(game.my_turn).to eq(true)
      expect(game.game_status).to eq(:active)
      expect(game.questions.size).to eq(1)
      expect(game.round_number).to eq(4)
      expect(game.opponent.username).to eq("example.2")
      expect(game.my_statistics).to_not be_nil
      expect(game.my_statistics.crowns.count).to eq(3)
      expect(game.opponent_statistics).to_not be_nil
      expect(game.opponent_statistics.crowns.count).to eq(1)
    end

    it "should parse raw data from the new game API" do
      game = TriviaCrack::Parsers::GameParser.parse new_game_data

      expect(game.id).to eq(2222)
      expect(game.language).to eq(:en)
      expect(game.my_turn).to eq(true)
      expect(game.game_status).to eq(:pending_approval)
      expect(game.questions.size).to eq(6)
      expect(game.round_number).to eq(1)
      expect(game.opponent.username).to eq("example.2")
      expect(game.my_statistics).to_not be_nil
      expect(game.my_statistics.crowns.count).to eq(0)
      expect(game.opponent_statistics).to_not be_nil
      expect(game.opponent_statistics.crowns.count).to eq(0)
    end

    it "should parse the date correctly" do
      game = TriviaCrack::Parsers::GameParser.parse game_data

      expect(game.created.day).to eq(18)
      expect(game.created.month).to eq(2)
      expect(game.created.year).to eq(2015)
      expect(game.created.hour).to eq(0)
      expect(game.created.min).to eq(11)
      expect(game.created.sec).to eq(33)
    end

  end

end
