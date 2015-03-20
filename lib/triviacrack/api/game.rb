require "triviacrack/api/common"
require "triviacrack/errors/request_error"
require "triviacrack/parsers/game_parser"

# Public: All methods in this module make requests to the Trivia Crack games
# API.
module TriviaCrack
  module API
    module Game

      include TriviaCrack::API::Common

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
        response = get "/api/users/#{@session.user_id}/dashboard"

        if response.code != 200
          raise TriviaCrack::Errors::RequestError.new(response.code),
            "Request to the Trivia Crack API failed."
        end

        games_data = response.body["list"]

        games = []
        if games_data
          games_data.each do |game_data|
            game = TriviaCrack::Parsers::GameParser.parse game_data
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
        response = get "/api/users/#{@session.user_id}/games/#{game_id}"

        if response.code != 200
          raise TriviaCrack::Errors::RequestError.new(response.code),
            "Request to the Trivia Crack API failed."
        end

        TriviaCrack::Parsers::GameParser.parse response.body
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
        response = post "/api/users/#{@session.user_id}/games",
                        parameters: { language: "EN" }.to_json

        if response.code != 201
          raise TriviaCrack::Errors::RequestError.new(response.code),
            "Request to the Trivia Crack API failed."
        end

        TriviaCrack::Parsers::GameParser.parse response.body
      end

    end
  end
end
