require "spec_helper"

describe TriviaCrack::Parsers::QuestionParser do

  describe ".from" do

    let(:answer_data) { SpecData.get "answer.json" }

    it "should parse raw data correctly" do
      question_data = answer_data["spins_data"]["spins"][0]["questions"][0]["question"]
      question_data["type"] = answer_data["spins_data"]["spins"][0]["type"]

      question = TriviaCrack::Parsers::QuestionParser.parse question_data

      expect(question.type).to eq(:normal)
      expect(question.text).to eq("What country is the soccer team Real Madrid from?")
      expect(question.category).to eq(:sports)
      expect(question.correct_answer).to eq(0)
      expect(question.answers.size).to eq(4)
    end
  end

end
