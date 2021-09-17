require "spec_helper"

describe TriviaCrack::API::Game do

  let(:session) { TriviaCrack::Session.new session_id: "session", user_id: 1 }
  let(:client) { (Class.new(APIStub) { include TriviaCrack::API::Game }).new session }

  let(:response) { double(status: code, body: raw_data) }

  before { allow(Faraday).to receive(:get) { response } }
  before { allow(Faraday).to receive(:post) { response } }

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
      it { expect{ subject }.to raise_error(an_instance_of(TriviaCrack::Errors::RequestError)
        .and having_attributes(code: 400)) }
      it { expect{ subject }.to raise_error(an_instance_of(TriviaCrack::Errors::RequestError)
        .and having_attributes(url: "/api/users/#{session.user_id}/dashboard")) }
    end
  end

  describe "#get_game" do
    let(:game_id) { 123 }

    subject { client.get_game game_id }

    let(:raw_data) { SpecData.get "game.json" }

    context 'given that the request is successful' do
      let(:code) { 200 }

      it { expect(TriviaCrack::Parsers::GameParser).to receive(:parse).once; subject }
      it { is_expected.to be_a TriviaCrack::Game }
    end

    context 'given that the request fails' do
      let(:code) { 400 }

      it { expect{ subject }.to raise_error TriviaCrack::Errors::RequestError }
      it { expect{ subject }.to raise_error(an_instance_of(TriviaCrack::Errors::RequestError)
        .and having_attributes(code: code)) }
      it { expect{ subject }.to raise_error(an_instance_of(TriviaCrack::Errors::RequestError)
        .and having_attributes(url: "/api/users/#{session.user_id}/games/#{game_id}")) }
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
      it { expect{ subject }.to raise_error(an_instance_of(TriviaCrack::Errors::RequestError)
        .and having_attributes(code: code)) }
      it { expect{ subject }.to raise_error(an_instance_of(TriviaCrack::Errors::RequestError)
        .and having_attributes(url: "/api/users/#{session.user_id}/games")) }
    end
  end
end
