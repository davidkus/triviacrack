require "triviacrack/api/common"
require "triviacrack/errors/request_error"
require "triviacrack/parsers/user_parser"

# Public: All methods in this module make requests to the Trivia Crack users
# API.
module TriviaCrack
  module API
    module User

      include TriviaCrack::API::Common

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

        response = get "/api/search?username=#{username}"

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
        response = get "/api/users/#{@session.user_id}"

        if response.code != 200
          raise TriviaCrack::Errors::RequestError.new(response.code)
        end

        TriviaCrack::Parsers::UserParser.parse response.body
      end

    end
  end
end
