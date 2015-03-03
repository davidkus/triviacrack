require "triviacrack/api/game"
require "triviacrack/api/login"
require "triviacrack/api/profile"
require "triviacrack/api/question"
require "triviacrack/api/user"

# Public: Interface for interacting with the Trivia Crack API.
module TriviaCrack
  module API
    class Client

      # Public: Sets the session for the API client to the given value.
      #
      # session  -  The TriviaCrack API session ID.
      def set_session(session)
        @session = session
      end

      include TriviaCrack::API::Game
      include TriviaCrack::API::Login
      include TriviaCrack::API::User
      include TriviaCrack::API::Question
      include TriviaCrack::API::Profile

    end
  end
end
