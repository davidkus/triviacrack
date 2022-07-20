# frozen_string_literal: true

require 'spec_helper'

describe TriviaCrack::API::Login do
  let(:client) { (Class.new(APIStub) { include TriviaCrack::API::Login }).new }

  let(:response) { double(status: code, body: raw_data) }

  before { allow(Faraday).to receive(:post) { response } }

  describe '#login' do
    subject { client.login email, password }

    let(:email) { 'user@example.com' }
    let(:password) { 'password123' }
    let(:raw_data) { SpecData.get 'login.json' }

    context 'given that the request is successful' do
      let(:code) { 200 }

      it {
        expect(TriviaCrack::Parsers::SessionParser).to receive(:parse).once
        subject
      }
      its(:user_id) { is_expected.to be 111 }
      its(:username) { is_expected.to eq 'example' }
      its(:session_id) { is_expected.to eq 'session123' }
    end

    context 'given that the request fails' do
      let(:code) { 400 }

      it { expect { subject }.to raise_error TriviaCrack::Errors::RequestError }
      it {
        expect { subject }.to raise_error(an_instance_of(TriviaCrack::Errors::RequestError)
        .and(having_attributes(code: code)))
      }
      it {
        expect { subject }.to raise_error(an_instance_of(TriviaCrack::Errors::RequestError)
        .and(having_attributes(url: '/api/login')))
      }
    end
  end
end
