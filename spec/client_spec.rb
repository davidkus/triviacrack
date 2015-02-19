require "spec_helper"

describe TriviaCrack::API::Client do

  before(:all) do
    @search_data = SpecData.get "search.json"
    @dashboard_data = SpecData.get "dashboard.json"
    @answer_data = SpecData.get "answer.json"
    @new_game_data = SpecData.get "new_game.json"
    @login_data = SpecData.get "login.json"
    @game_data = SpecData.get "game.json"
    @user_data = SpecData.get "user.json"
    @error_code = 400

    @client = TriviaCrack::API::Client.new
  end

  describe "#login" do
    it "should return correct user id and username when succesful" do
      response = double(code: 200, body: @login_data)

      allow(Unirest).to receive(:post) { response }

      result = @client.login "user@example.com", "password123"

      expect(result[:user_id]).to eq(111)
      expect(result[:username]).to eq("example")
    end

    it "should set the session id to the value returned by the request" do
      response = double(code: 200, body: @login_data)

      allow(Unirest).to receive(:post) { response }

      expect(Unirest).to receive(:default_header).with("Cookie", "ap_session=session123")

      @client.login "user@example.com", "password123"
    end

    it "should raise an exception when request fails" do
      response = double(code: @error_code)

      allow(Unirest).to receive(:post) { response }

      expect { @client.login "user@example.com", "password123" }.to raise_error
    end
  end

  describe "#get_user_id" do
    it "should return the correct user id" do
      response = double(code: 200, body: @search_data)

      allow(Unirest).to receive(:get) { response }

      user_id = @client.get_user_id "@example.2"

      expect(user_id).to eq(112)
    end

    it "should raise an exception when request fails" do
      response = double(code: @error_code)

      allow(Unirest).to receive(:get) { response }

      expect { @client.get_user_id "@example" }.to raise_error
    end
  end

  describe "#get_user" do
    it "should return a correctly constructed user object" do
      response = double(code: 200, body: @dashboard_data)

      allow(Unirest).to receive(:get) { response }

      user = @client.get_user

      expect(user).to_not be_nil
    end

    it "should raise an exception when request fails" do
      response = double(code: @error_code)

      allow(Unirest).to receive(:get) { response }

      expect { @client.get_user 112 }.to raise_error
    end
  end

  describe "#answer_question" do
    before(:each) do
      @question = double(id: 1, correct_answer: 1, type: "NORMAL",
                         category: "SPORTS")
      @user = double(id: 1234)
      allow(@user).to receive(:level=)
      allow(@user).to receive(:progress=)
      @game = double(id: 22)
      allow(@game).to receive(:update)
    end

    it "should return true when answered correctly" do
      response = double(code: 200, body: @answer_data)

      allow(Unirest).to receive(:post) { response }

      result = @client.answer_question @game.id, @question, 1

      expect(result).to eq(true)
    end

    it "should return false when answered incorrectly" do
      response = double(code: 200, body: @answer_data)

      allow(Unirest).to receive(:post) { response }

      result = @client.answer_question @game.id, @question, 0

      expect(result).to eq(false)
    end

    it "should raise an exception when request fails" do
      response = double(code: @error_code)

      allow(Unirest).to receive(:post) { response }

      expect { @client.answer_question @game.id, @question, 1 }.to raise_error
    end
  end

  describe "#get_games" do
    it "should return list of games from the dashboard API" do
      response = double(code: 200, body: @dashboard_data)

      allow(Unirest).to receive(:get) { response }

      games = @client.get_games

      expect(games[0].id).to eq(1111)
      expect(games[1].id).to eq(1112)
      expect(games[2].id).to eq(1113)
      expect(games[3].id).to eq(1115)
      expect(games[4].id).to eq(1116)
      expect(games[5].id).to eq(1117)
      expect(games[6].id).to eq(1118)
      expect(games.size).to eq(7)
    end

    it "should raise an exception when request fails" do
      response = double(code: @error_code)

      allow(Unirest).to receive(:get) { response }

      expect { @client.get_games }.to raise_error
    end
  end

  describe "#get_game" do
    it "should return the game from the data retrieved from the API" do
      response = double(code: 200, body: @game_data)

      allow(Unirest).to receive(:get) { response }

      game = @client.get_game 1111

      expect(game.id).to eq(1111)
      expect(game.language).to eq("EN")
    end

    it "should raise an exception when request fails" do
      response = double(code: @error_code)

      allow(Unirest).to receive(:get) { response }

      expect { @client.get_game 123 }.to raise_error
    end
  end

  describe "#start_new_game" do
    before(:each) do
      @user = double(id: 1234, games: [])
    end

    it "should create a new game and return it" do
      response = double(code: 201, body: @new_game_data)

      allow(Unirest).to receive(:post) { response }

      game = @client.start_new_game

      expect(game.id).to be(2222)
      expect(game.language).to eq("EN")
      expect(game.playable?).to eq(true)
    end

    it "should raise an exception when request fails" do
      response = double(code: @error_code)

      allow(Unirest).to receive(:post) { response }

      expect { @client.start_new_game }.to raise_error
    end
  end
end
