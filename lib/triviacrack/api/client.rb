require "triviacrack/api/game"
require "triviacrack/api/login"
require "triviacrack/api/profile"
require "triviacrack/api/question"
require "triviacrack/api/user"

# Public: Interface for interacting with the Trivia Crack API.
module TriviaCrack
  module API
    class Client

      include TriviaCrack::API::Game
      include TriviaCrack::API::Login
      include TriviaCrack::API::User
      include TriviaCrack::API::Question
      include TriviaCrack::API::Profile

      # Public: Creates a new TriviaCrack::Session object using the given
      # session_id and user_id and assigns that session to this
      # TriviaCrack::API::Client.
      #
      # session_id - The Trivia Crack session ID.
      # user_id    - The Trivia Crack user ID.
      def set_session(session_id, user_id)
        @session = TriviaCrack::Session.new session_id: session_id,
                                            user_id: user_id
      end

    end
  end
end
