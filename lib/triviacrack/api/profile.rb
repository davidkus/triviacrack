require "triviacrack/api/common"

# Public: Interface to the Trivia Crack Profile API.
module TriviaCrack
  module API
    module Profile

      include TriviaCrack::API::Common

      # Public: Uses the Trivia Crack API to get the profile of the user with
      # the given user id.
      #
      # user_id  - The unique identifier of the user.
      #
      # Examples
      #
      #   profile = client.get_profile 123
      #
      # Returns the TriviaCrack::Profile for the given user.
      # Raises TriviaCrack::Errors::RequestError if the request fails.
      def get_profile(user_id)
        response = get "/api/users/#{@session.user_id}/profiles/#{user_id}"

        TriviaCrack::Parsers::ProfileParser.parse response.body
      end

      # Public: Uses the Trivia Crack API to get the profile of current user.
      #
      # Examples
      #
      #   profile = client.get_my_profile
      #
      # Returns the TriviaCrack::Profile for the current user.
      # Raises TriviaCrack::Errors::RequestError if the request fails.
      def get_my_profile
        response =
          get "/api/users/#{@session.user_id}/profiles/#{@session.user_id}"

        TriviaCrack::Parsers::ProfileParser.parse response.body
      end

    end
  end
end
