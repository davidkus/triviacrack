require "spec_helper"

describe TriviaCrack::Parsers::SessionParser do

  describe ".parse" do

    let(:login_data) { SpecData.get "login.json" }

    it "should parse raw data correctly" do
      session = TriviaCrack::Parsers::SessionParser.parse login_data

      expect(session.user_id).to eq(111)
      expect(session.username).to eq("example")
      expect(session.session_id).to eq("session123")
      expect(session.device_key).to eq("device123")

      expect(session.expiration.year).to eq(2015)
      expect(session.expiration.month).to eq(3)
      expect(session.expiration.day).to eq(21)
      expect(session.expiration.hour).to eq(11)
      expect(session.expiration.min).to eq(7)
      expect(session.expiration.sec).to eq(42r)
    end

  end

end
