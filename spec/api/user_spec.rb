require "spec_helper"

describe TriviaCrack::API::User do

  let(:client) { (Class.new { include TriviaCrack::API::User }).new }
  let(:search_data) { SpecData.get "search.json" }
  let(:dashboard_data) { SpecData.get "dashboard.json" }
  let(:error_code) { 400 }

  describe "#get_user_id" do
    it "should return the correct user id" do
      response = double(code: 200, body: search_data)

      allow(Unirest).to receive(:get) { response }

      user_id = client.get_user_id "@example.2"

      expect(user_id).to eq(112)
    end

    it "should raise an exception when request fails" do
      response = double(code: error_code)

      allow(Unirest).to receive(:get) { response }

      expect { client.get_user_id "@example" }.to raise_error
    end
  end

  describe "#get_user" do
    it "should return a correctly constructed user object" do
      response = double(code: 200, body: dashboard_data)

      allow(Unirest).to receive(:get) { response }

      user = client.get_user

      expect(user).to_not be_nil
    end

    it "should raise an exception when request fails" do
      response = double(code: error_code)

      allow(Unirest).to receive(:get) { response }

      expect { client.get_user 112 }.to raise_error
    end
  end

end
