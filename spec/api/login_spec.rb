require "spec_helper"

describe TriviaCrack::API::Login do

  let(:session) { TriviaCrack::Session.new session_id: "a", user_id: 1 }
  let(:client) { (Class.new(APIStub) { include TriviaCrack::API::Login }).new session }

  let(:login_data) { SpecData.get "login.json" }
  let(:error_code) { 400 }

  describe "#login" do
    it "should return correct user id and username when succesful" do
      response = double(code: 200, body: login_data)

      allow(Unirest).to receive(:post) { response }

      session = client.login "user@example.com", "password123"

      expect(session.user_id).to eq(111)
      expect(session.username).to eq("example")
      expect(session.session_id).to eq("session123")
    end

    it "should raise an exception when request fails" do
      response = double(code: error_code)

      allow(Unirest).to receive(:post) { response }

      expect { client.login "user@example.com", "password123" }.to raise_error
    end
  end

end
