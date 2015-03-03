require "spec_helper"

describe TriviaCrack::API::Profile do

  let(:client) { (Class.new { include TriviaCrack::API::Profile }).new }
  let(:profile_data) { SpecData.get "profile.json" }
  let(:my_profile_data) { SpecData.get "my_profile.json" }
  let(:error_code) { 400 }

  describe "#get_profile" do
    it "should return a profile object" do
      response = double(code: 200, body: profile_data)

      allow(Unirest).to receive(:get) { response }

      profile = client.get_profile 111

      expect(profile.username).to eq("example")
    end

    it "should raise an exception when request fails" do
      response = double(code: error_code)

      allow(Unirest).to receive(:get) { response }

      expect { client.get_profile 111 }.to raise_error
    end
  end

  describe "#get_my_profile" do
    it "should return a profile object" do
      response = double(code: 200, body: my_profile_data)

      allow(Unirest).to receive(:get) { response }

      profile = client.get_my_profile

      expect(profile.username).to eq("example2")
    end

    it "should raise an exception when request fails" do
      response = double(code: error_code)

      allow(Unirest).to receive(:get) { response }

      expect { client.get_my_profile }.to raise_error
    end
  end

end
