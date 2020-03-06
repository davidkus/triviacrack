require "spec_helper"

describe TriviaCrack::API::Profile do

  let(:session) { TriviaCrack::Session.new session_id: "session", user_id: 1 }
  let(:client) { (Class.new(APIStub) { include TriviaCrack::API::Profile }).new session }

  let(:response) { double(code: code, body: raw_data) }

  before { allow(Unirest).to receive(:get) { response } }

  describe "#get_profile" do
    let(:user_id) { 111 }

    subject { client.get_profile user_id }

    let(:raw_data) { SpecData.get "profile.json" }

    context 'given that the request is successful' do
      let(:code) { 200 }

      it { expect(TriviaCrack::Parsers::ProfileParser).to receive(:parse).once; subject }
      it { is_expected.to be_a TriviaCrack::Profile }
    end

    context 'given that the request fails' do
      let(:code) { 400 }

      it { expect{ subject }.to raise_error TriviaCrack::Errors::RequestError }
      it { expect{ subject }.to raise_error(an_instance_of(TriviaCrack::Errors::RequestError)
        .and having_attributes(code: code)) }
      it { expect{ subject }.to raise_error(an_instance_of(TriviaCrack::Errors::RequestError)
        .and having_attributes(url: "/api/users/#{session.user_id}/profiles/#{user_id}")) }
    end
  end

  describe "#get_my_profile" do

    subject { client.get_my_profile }

    let(:raw_data) { SpecData.get "my_profile.json" }

    context 'given that the request is successful' do
      let(:code) { 200 }

      it { expect(TriviaCrack::Parsers::ProfileParser).to receive(:parse).once; subject }
      it { is_expected.to be_a TriviaCrack::Profile }
    end

    context 'given that the request fails' do
      let(:code) { 400 }

      it { expect{ subject }.to raise_error TriviaCrack::Errors::RequestError }
      it { expect{ subject }.to raise_error(an_instance_of(TriviaCrack::Errors::RequestError)
        .and having_attributes(code: code)) }
      it { expect{ subject }.to raise_error(an_instance_of(TriviaCrack::Errors::RequestError)
        .and having_attributes(url: "/api/users/#{session.user_id}/profiles/#{session.user_id}")) }
    end
  end
end
