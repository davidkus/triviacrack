require "spec_helper"

describe TriviaCrack::API::Question do

  let(:session) { TriviaCrack::Session.new session_id: "session", user_id: 1 }
  let(:client) { (Class.new(APIStub) { include TriviaCrack::API::Question }).new session }

  let(:response) { double(status: code, body: raw_data) }

  before { allow(Faraday).to receive(:post) { response } }

  describe "#answer_question" do

    subject { client.answer_question game_id, question, answer }

    let(:raw_data) { SpecData.get "answer.json" }
    let(:question) { double(id: 1, correct_answer: 1, type: "NORMAL", category: "SPORTS") }
    let(:game_id) { 22 }

    context 'given that the question was answered correctly' do
      let(:code) { 200 }
      let(:answer) { 1 }

      it { expect(TriviaCrack::Parsers::GameParser).to receive(:parse).once; subject }
      it { expect(subject[0]).to be_a TriviaCrack::Game }
      it { expect(subject[1]).to be true }
    end

    context 'given that the question was answered incorrectly' do
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

  describe "#answer_questions" do

    subject { client.answer_questions game_id, questions, answers }

    let(:raw_data) { SpecData.get "answer.json" }
    let(:question_one) { double(id: 1, correct_answer: 1, type: "DUEL", category: "SPORTS") }
    let(:question_two) { double(id: 2, correct_answer: 2, type: "DUEL", category: "ART") }
    let(:questions) { [question_one, question_two] }
    let(:game_id) { 22 }

    context 'given that the questions were answered correctly' do
      let(:code) { 200 }
      let(:answers) { {1 => 1, 2 => 2} }

      it { expect(TriviaCrack::Parsers::GameParser).to receive(:parse).once; subject }
      it { expect(subject[0]).to be_a TriviaCrack::Game }
      it { expect(subject[1][1]).to be true }
      it { expect(subject[1][2]).to be true }
    end

    context 'given that a question was answered incorrectly' do
      let(:code) { 200 }
      let(:answers) { {1 => 1, 2 => 3} }

      it { expect(TriviaCrack::Parsers::GameParser).to receive(:parse).once; subject }
      it { expect(subject[0]).to be_a TriviaCrack::Game }
      it { expect(subject[1][1]).to be true }
      it { expect(subject[1][2]).to be false }
    end

    context 'given that the request fails' do
      let(:code) { 400 }
      let(:answers) { {1 => 1, 2 => 2} }

      it { expect{ subject }.to raise_error TriviaCrack::Errors::RequestError }
      it { expect{ subject }.to raise_error(an_instance_of(TriviaCrack::Errors::RequestError)
        .and having_attributes(code: code)) }
      it { expect{ subject }.to raise_error(an_instance_of(TriviaCrack::Errors::RequestError)
        .and having_attributes(url: "/api/users/#{session.user_id}/games/#{game_id}/answers")) }
    end
  end
end
