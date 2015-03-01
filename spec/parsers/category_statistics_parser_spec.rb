require "spec_helper"

describe TriviaCrack::Parsers::CategoryStatisticsParser do

  describe ".parse" do

    let(:game_data) { SpecData.get "game.json" }
    let(:dashboard_data) { SpecData.get "dashboard.json" }
    let(:answer_data) { SpecData.get "answer.json" }

    it "should parse raw data from games API" do
      player_statistics = game_data["statistics"]["player_one_statistics"]
      category_data = player_statistics["category_questions"].first

      category_statistics =
        TriviaCrack::Parsers::CategoryStatisticsParser.parse category_data

      expect(category_statistics.category).to eq("GEOGRAPHY")
      expect(category_statistics.correct).to eq(2)
      expect(category_statistics.incorrect).to eq(1)
      expect(category_statistics.worst).to eq(false)
    end

    it "should parse raw data from dashboard API" do
      game = dashboard_data["list"][3]
      player_statistics = game["statistics"]["player_one_statistics"]
      category_data = player_statistics["category_questions"].first

      category_statistics =
        TriviaCrack::Parsers::CategoryStatisticsParser.parse category_data

      expect(category_statistics.category).to eq("ARTS")
      expect(category_statistics.correct).to eq(3)
      expect(category_statistics.incorrect).to eq(0)
      expect(category_statistics.worst).to eq(false)
    end

    it "should parse raw data from answers API" do
      player_statistics = answer_data["statistics"]["player_one_statistics"]
      category_data = player_statistics["category_questions"].first

      category_statistics =
        TriviaCrack::Parsers::CategoryStatisticsParser.parse category_data

      expect(category_statistics.category).to eq("SPORTS")
      expect(category_statistics.correct).to eq(1)
      expect(category_statistics.incorrect).to eq(0)
      expect(category_statistics.worst).to eq(false)
    end
  end
end
