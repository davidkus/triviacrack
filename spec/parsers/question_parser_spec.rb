require "spec_helper"

describe TriviaCrack::Parsers::QuestionParser do

  describe ".parse" do

    let(:answer_data) { SpecData.get "answer.json" }
    let(:image_data) { SpecData.get "question_image.json" }

    it "should parse raw data correctly" do
      question_data = answer_data["spins_data"]["spins"][0]["questions"][0]["question"]
      question_data["type"] = answer_data["spins_data"]["spins"][0]["type"]

      question = TriviaCrack::Parsers::QuestionParser.parse question_data

      expect(question.type).to eq(:normal)
      expect(question.text).to eq("What country is the soccer team Real Madrid from?")
      expect(question.category).to eq(:sports)
      expect(question.correct_answer).to eq(0)
      expect(question.answers.size).to eq(4)
      expect(question.media_type).to eq(:normal)
    end

    it "should parse correctly when the question has an image associated" do
      question = TriviaCrack::Parsers::QuestionParser.parse image_data

      expect(question.media_type).to eq(:image)
      expect(question.text).to eq("Who recorded this album?")
      expect(question.category).to eq(:entertainment)
      expect(question.correct_answer).to eq(3)
      expect(question.answers.size).to eq(4)
      expect(question.image_url).to eq("http://qimg.preguntados.com/ENT_3028")
    end

  end

end
