require "triviacrack/api/common"
require "triviacrack/parsers/session_parser"

# Public: All methods in this module make requests to the Trivia Crack login
# API.
module TriviaCrack
  module API
    module Login

      include TriviaCrack::API::Common

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
      # Returns the user_id and username of the user that has logged in.
      # Raises TriviaCrack::Errors::RequestError if the request fails.
      def login(email, password)
        response = post "/api/login", parameters: { email: email,
                                                    password: password,
                                                    language: "en"
                                                  }.to_s

        @session = TriviaCrack::Parsers::SessionParser.parse response.body
      end

    end
  end
end
