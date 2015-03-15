require "spec_helper"

describe TriviaCrack::API::Question do

  let(:session) { TriviaCrack::Session.new session_id: "a", user_id: 1 }
  let(:client) { (Class.new(APIStub) { include TriviaCrack::API::Question }).new session }

  let(:answer_data) { SpecData.get "answer.json" }
  let(:error_code) { 400 }

  describe "#answer_question" do

    let(:question) { double(id: 1, correct_answer: 1, type: "NORMAL",
                            category: "SPORTS") }
    let(:game_id) { 22 }

    it "should return true when answered correctly" do
      response = double(code: 200, body: answer_data)

      allow(Unirest).to receive(:post) { response }

      game, result = client.answer_question game_id, question, 1

      expect(result).to eq(true)
    end

    it "should return false when answered incorrectly" do
      response = double(code: 200, body: answer_data)

      allow(Unirest).to receive(:post) { response }

      game, result = client.answer_question game_id, question, 0

      expect(result).to eq(false)
    end

    it "should raise an exception when request fails" do
      response = double(code: error_code)

      allow(Unirest).to receive(:post) { response }

      expect { client.answer_question game_id, question, 1 }.to raise_error
    end
  end

end
