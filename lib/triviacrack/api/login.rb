require "unirest"

require "triviacrack/api/constants"
require "triviacrack/errors/request_error"

# Public: All methods in this module make requests to the Trivia Crack login
# API.
module TriviaCrack
  module API
    module Login

      include TriviaCrack::API::Constants

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
        @user_id = body["id"]
        @username = body["username"]

        Unirest.default_header("Cookie", "ap_session=#{@session}")

        [body["id"], body["username"]]
      end

    end
  end
end
