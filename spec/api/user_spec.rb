require "spec_helper"

describe TriviaCrack::API::User do

  let(:session) { TriviaCrack::Session.new session_id: "session", user_id: 1 }
  let(:client) { (Class.new(APIStub) { include TriviaCrack::API::User }).new session }

  let(:response) { double(code: code, body: raw_data) }

  before { allow(Unirest).to receive(:get) { response } }

  describe "#get_user_id" do
    let(:username) { "example.2" }

    subject { client.get_user_id username }

    let(:raw_data) { SpecData.get "search.json" }

    context 'given that the request is successful' do
      let(:code) { 200 }

      it { is_expected.to be 112 }
    end

    context 'given that the request fails' do
      let(:code) { 400 }

      it { expect{ subject }.to raise_error TriviaCrack::Errors::RequestError }
      it { expect{ subject }.to raise_error(an_instance_of(TriviaCrack::Errors::RequestError)
        .and having_attributes(code: code)) }
      it { expect{ subject }.to raise_error(an_instance_of(TriviaCrack::Errors::RequestError)
        .and having_attributes(url: "/api/search?username=#{username}")) }
    end
  end

  describe "#get_user" do

    subject { client.get_user }

    let(:raw_data) { SpecData.get "dashboard.json" }

    context 'given that the request is successful' do
      let(:code) { 200 }

      it { expect(TriviaCrack::Parsers::UserParser).to receive(:parse).once; subject }
      it { is_expected.to be_a TriviaCrack::User }
    end

    context 'given that the request fails' do
      let(:code) { 400 }

      it { expect{ subject }.to raise_error TriviaCrack::Errors::RequestError }
      it { expect{ subject }.to raise_error(an_instance_of(TriviaCrack::Errors::RequestError)
        .and having_attributes(code: code)) }
      it { expect{ subject }.to raise_error(an_instance_of(TriviaCrack::Errors::RequestError)
        .and having_attributes(url: "/api/users/#{session.user_id}")) }
    end
  end
end
