require "spec_helper"

describe TriviaCrack::API::Game do

  let(:session) { TriviaCrack::Session.new session_id: "session", user_id: 1 }
  let(:client) { (Class.new(APIStub) { include TriviaCrack::API::Game }).new session }

  let(:response) { double(code: code, body: raw_data) }

  before { allow(Unirest).to receive(:get) { response } }
  before { allow(Unirest).to receive(:post) { response } }

  describe "#get_games" do

    subject { client.get_games[3] }

    let(:raw_data) { SpecData.get "dashboard.json" }

    context 'given that the request is successful' do
      let(:code) { 200 }

      it { expect(TriviaCrack::Parsers::GameParser).to receive(:parse).at_least 1; subject }
      it { is_expected.to be_a TriviaCrack::Game }
    end

    context 'given that the request fails' do
      let(:code) { 400 }

      it { expect{ subject }.to raise_error TriviaCrack::Errors::RequestError }
    end
  end

  describe "#get_game" do

    subject { client.get_game 123 }

    let(:raw_data) { SpecData.get "game.json" }

    context 'given that the request is successful' do
      let(:code) { 200 }

      it { expect(TriviaCrack::Parsers::GameParser).to receive(:parse).once; subject }
      it { is_expected.to be_a TriviaCrack::Game }
    end

    context 'given that the request fails' do
      let(:code) { 400 }

      it { expect{ subject }.to raise_error TriviaCrack::Errors::RequestError }
    end
  end

  describe "#start_new_game" do

    subject { client.start_new_game }

    let(:raw_data) { SpecData.get "new_game.json" }

    context 'given that the request is successful' do
      let(:code) { 201 }

      it { expect(TriviaCrack::Parsers::GameParser).to receive(:parse).once; subject }
      it { is_expected.to be_a TriviaCrack::Game }
    end

    context 'given that the request fails' do
      let(:code) { 400 }

      it { expect{ subject }.to raise_error TriviaCrack::Errors::RequestError }
    end
  end
end
