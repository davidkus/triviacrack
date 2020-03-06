require "spec_helper"

describe TriviaCrack::API::Question do

  let(:session) { TriviaCrack::Session.new session_id: "session", user_id: 1 }
  let(:client) { (Class.new(APIStub) { include TriviaCrack::API::Question }).new session }

  let(:response) { double(code: code, body: raw_data) }

  before { allow(Unirest).to receive(:post) { response } }

  describe "#answer_question" do

    subject { client.answer_question game_id, question, answer }

    let(:raw_data) { SpecData.get "answer.json" }
    let(:question) { double(id: 1, correct_answer: 1, type: "NORMAL", category: "SPORTS") }
    let(:game_id) { 22 }

    context 'given that the question was answer correctly' do
      let(:code) { 200 }
      let(:answer) { 1 }

      it { expect(TriviaCrack::Parsers::GameParser).to receive(:parse).once; subject }
      it { expect(subject[0]).to be_a TriviaCrack::Game }
      it { expect(subject[1]).to be true }
    end

    context 'given that the question was answer incorrectly' do
      let(:code) { 200 }
      let(:answer) { 0 }

      it { expect(TriviaCrack::Parsers::GameParser).to receive(:parse).once; subject }
      it { expect(subject[0]).to be_a TriviaCrack::Game }
      it { expect(subject[1]).to be false }
    end

    context 'given that the request fails' do
      let(:code) { 400 }
      let(:answer) { 1 }

      it { expect{ subject }.to raise_error TriviaCrack::Errors::RequestError }
      it { expect{ subject }.to raise_error(an_instance_of(TriviaCrack::Errors::RequestError)
        .and having_attributes(code: code)) }
      it { expect{ subject }.to raise_error(an_instance_of(TriviaCrack::Errors::RequestError)
        .and having_attributes(url: "/api/users/#{session.user_id}/games/#{game_id}/answers")) }
    end
  end
end
