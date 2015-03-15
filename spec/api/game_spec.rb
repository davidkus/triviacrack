require "spec_helper"

describe TriviaCrack::API::Game do

  let(:session) { TriviaCrack::Session.new session_id: "a", user_id: 1 }
  let(:client) { (Class.new(APIStub) { include TriviaCrack::API::Game }).new session }

  let(:dashboard_data) { SpecData.get "dashboard.json" }
  let(:new_game_data) { SpecData.get "new_game.json" }
  let(:game_data) { SpecData.get "game.json" }
  let(:error_code) { 400 }

  describe "#get_games" do
    it "should return list of games from the dashboard API" do
      response = double(code: 200, body: dashboard_data)

      allow(Unirest).to receive(:get) { response }

      games = client.get_games

      expect(games[0].id).to eq(1111)
      expect(games[1].id).to eq(1112)
      expect(games[2].id).to eq(1113)
      expect(games[3].id).to eq(1115)
      expect(games[4].id).to eq(1116)
      expect(games[5].id).to eq(1117)
      expect(games[6].id).to eq(1118)
      expect(games[3].questions[0].id).to eq(15593975)
      expect(games.size).to eq(7)
    end

    it "should raise an exception when request fails" do
      response = double(code: error_code)

      allow(Unirest).to receive(:get) { response }

      expect { client.get_games }.to raise_error
    end
  end

  describe "#get_game" do
    it "should return the game from the data retrieved from the API" do
      response = double(code: 200, body: game_data)

      allow(Unirest).to receive(:get) { response }

      game = client.get_game 1111

      expect(game.id).to eq(1111)
      expect(game.language).to eq(:en)
    end

    it "should raise an exception when request fails" do
      response = double(code: error_code)

      allow(Unirest).to receive(:get) { response }

      expect { client.get_game 123 }.to raise_error
    end
  end

  describe "#start_new_game" do

    let(:user) { double(id: 1234, games: [] ) }

    it "should create a new game and return it" do
      response = double(code: 201, body: new_game_data)

      allow(Unirest).to receive(:post) { response }

      game = client.start_new_game

      expect(game.id).to be(2222)
      expect(game.language).to eq(:en)
      expect(game.playable?).to eq(true)
    end

    it "should raise an exception when request fails" do
      response = double(code: error_code)

      allow(Unirest).to receive(:post) { response }

      expect { client.start_new_game }.to raise_error
    end
  end

end
