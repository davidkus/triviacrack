require "spec_helper"

describe TriviaCrack::Parsers::GameStatisticsParser do

  describe ".parse" do

    let(:game_data) { SpecData.get "game.json" }
    let(:dashboard_data) { SpecData.get "dashboard.json" }
    let(:answer_data) { SpecData.get "answer.json" }
    let(:new_game_data) { SpecData.get "new_game.json" }

    it "should parse raw data from games API" do
      statistics_data = game_data["statistics"]["player_one_statistics"]
      statistics_data["crowns"] = game_data["player_one"]["crowns"]
      game_statistics =
        TriviaCrack::Parsers::GameStatisticsParser.parse statistics_data

      expect(game_statistics.correct_answers).to eq(12)
      expect(game_statistics.incorrect_answers).to eq(3)
      expect(game_statistics.challenges_won).to eq(0)
      expect(game_statistics.questions_answered).to eq(15)
      expect(game_statistics.crowns.length).to eq(3)
    end

    it "should parse raw data from the dashboard API" do
      game = dashboard_data["list"][3]
      statistics_data = game["statistics"]["player_one_statistics"]
      statistics_data["crowns"] = game["player_one"]["crowns"]
      game_statistics =
        TriviaCrack::Parsers::GameStatisticsParser.parse statistics_data

      expect(game_statistics.correct_answers).to eq(13)
      expect(game_statistics.incorrect_answers).to eq(3)
      expect(game_statistics.challenges_won).to eq(0)
      expect(game_statistics.questions_answered).to eq(16)
      expect(game_statistics.crowns.length).to eq(3)
    end

    it "should parse raw data from the answer API" do
      statistics_data = answer_data["statistics"]["player_one_statistics"]
      statistics_data["crowns"] = answer_data["player_one"]["crowns"]
      game_statistics =
        TriviaCrack::Parsers::GameStatisticsParser.parse statistics_data

      expect(game_statistics.correct_answers).to eq(13)
      expect(game_statistics.incorrect_answers).to eq(3)
      expect(game_statistics.challenges_won).to eq(0)
      expect(game_statistics.questions_answered).to eq(16)
      expect(game_statistics.crowns.length).to eq(3)
    end

    it "should parse raw data from the new game API" do
      statistics_data = new_game_data["statistics"]["player_one_statistics"]
      statistics_data["crowns"] = new_game_data["player_one"]["crowns"]
      game_statistics =
        TriviaCrack::Parsers::GameStatisticsParser.parse statistics_data

        expect(game_statistics.correct_answers).to eq(0)
        expect(game_statistics.incorrect_answers).to eq(0)
        expect(game_statistics.challenges_won).to eq(0)
        expect(game_statistics.questions_answered).to eq(0)
        expect(game_statistics.crowns.length).to eq(0)
    end
  end
end
