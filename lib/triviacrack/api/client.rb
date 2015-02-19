require 'unirest'

require "triviacrack/game"
require "triviacrack/question"
require "triviacrack/user"
require "triviacrack/errors/request_error"

module TriviaCrack
  module API
    class Client

      API_HOST = "https://api.preguntados.com"

      def initialize
        Unirest.default_header("Content-Type", "application/json; charset=utf-8")
      end

      # Public: Uses the given email and password to log in to Trivia Crack
      # and retrieve a session id and user id.
      #
      # email     - Email of a Trivia Crack user.
      # password  - Password of a Trivia Crack user.
      #
      # Examples
      #
      #   login "user@example.com", "password123"
      #
      # Returns the user_id, username of the user that has logged in.
      # Raises TriviaCrack::Errors::RequestError if the request fails.
      def login(email, password)
        response = Unirest.post "#{API_HOST}/api/login",
        parameters: { email: email,
          password: password,
          language: "en"
        }.to_json

        if response.code != 200
          raise TriviaCrack::Errors::RequestError.new(response.code)
        end

        body = response.body

        @session = body["session"]["session"]

        Unirest.default_header("Cookie", "ap_session=#{@session}")

        {
          user_id: body["id"],
          username: body["username"]
        }
      end

      # Public: Uses the Trivia Crack Search API to find the numeric user id of
      # the user identified by the given username.
      #
      # username  - Trivia Crack username of a user (e.g. "@example").
      #
      # Examples
      #
      #   get_user_id "@example"
      #
      # Returns the user id of the user.
      # Raises TriviaCrack:Errors::RequestError if the request fails.
      def get_user_id(username)
        # Trim the @ character from the start of the username
        if username.start_with? "@"
          username = username[1..-1]
        end

        response = Unirest.get "#{API_HOST}/api/search?username=#{username}"

        if response.code != 200
          raise TriviaCrack::Errors::RequestError.new(response.code)
        end

        body = response.body

        user_id = false
        body["list"].each do |user|
          if user["username"] == username
            user_id = user["id"]
            break
          end
        end

        user_id
      end

      # Public: Uses the Trivia Crack API to retrieve the user data.
      #
      # Returns a TriviaCrack::User representing the current user.
      # Raises TriviaCrack::Errors::RequestError if the request fails
      def get_user
        response = Unirest.get "#{API_HOST}/api/users/#{@user_id}"

        if response.code != 200
          raise TriviaCrack::Errors::RequestError.new(response.code)
        end

        TriviaCrack::User.from response.body
      end

      # Public: Uses the Trivia Crack API to fetch the list of games for the
      # current user.
      #
      # Examples
      #
      #   get_games
      #
      # Returns a list of TriviaCrack::Game.
      # Raises TriviaCrack:Errors::RequestError if the request fails.
      def get_games
        response = Unirest.get "#{API_HOST}/api/users/#{@user_id}/dashboard"

        if response.code != 200
          raise TriviaCrack::Errors::RequestError.new(response.code)
        end

        games_data = response.body["list"]

        games = []
        if games_data
          games_data.each do |game_data|
            game = TriviaCrack::Game.from game_data
            games << game
          end
        end
        games
      end

      # Public: Uses the Trivia Crack API to fetch the information for the given
      # game.
      #
      # game_id  - The id of a Trivia Crack game.
      #
      # Examples
      #
      #   get_game 123
      #
      # Returns the TriviaCrack::Game for the given game_id.
      # Raises TriviaCrack:Errors::RequestError if the request fails.
      def get_game(game_id)
        response = Unirest.get "#{API_HOST}/api/users/#{@user_id}/games/#{game_id}"

        if response.code != 200
          raise TriviaCrack::Errors::RequestError.new(response.code)
        end

        TriviaCrack::Game.from response.body
      end

      # Public: Uses the Trivia Crack API to answer the given question.
      #
      # game      - The ID of the TriviaCrack::Game.
      # question  - The TriviaCrack::Question.
      # answer    - Integer.
      #
      # Examples
      #
      #   answer_question game.id, question, 1
      #
      # Returns a boolean indicating whether or not the question was answered
      # correctly.
      # Raises TriviaCrack::Errors::RequestError if the request fails
      def answer_question(game_id, question, answer)
        response = Unirest.post "#{API_HOST}/api/users/#{@user_id}/games/#{game_id}/answers",
                      parameters: { type: question.type,
                        answers: [{ id: question.id,
                          answer: answer,
                          category: question.category
                          }]
                        }.to_json

        if response.code != 200
          raise TriviaCrack::Errors::RequestError.new(response.code)
        end

        answer == question.correct_answer
      end

      # Public: Uses the Trivia Crack API to start a new game for the current
      # user.
      #
      # Examples
      #
      #   client.start_new_game
      #
      # Returns the TriviaCrack::Game that was started.
      # Raises TriviaCrack::Errors::RequestError if the request fails
      def start_new_game
        response = Unirest.post "#{API_HOST}/api/users/#{@user_id}/games",
                                parameters: { language: "EN" }.to_json

        if response.code != 201
          raise TriviaCrack::Errors::RequestError.new(response.code)
        end

        TriviaCrack::Game.from response.body
      end

    end
  end
end
