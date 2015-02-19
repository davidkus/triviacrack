require_relative "spec_helper"

describe TriviaCrack::Question do
  describe ".from" do
    it "should parse raw data correctly" do
      answer_data = SpecData.get "answer.json"

      question_data = answer_data["spins_data"]["spins"][0]["questions"][0]["question"]
      question_data["type"] = answer_data["spins_data"]["spins"][0]["type"]

      question = TriviaCrack::Question.from question_data

      expect(question.type).to eq("NORMAL")
      expect(question.text).to eq("What country is the soccer team Real Madrid from?")
      expect(question.category).to eq("SPORTS")
      expect(question.correct_answer).to eq(0)
      expect(question.answers.size).to eq(4)
    end
  end
end
