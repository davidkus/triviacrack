require "unirest"

require "triviacrack/api/constants"

# Public: Interface to the Trivia Crack Profile API.
module TriviaCrack
  module API
    module Profile

      include TriviaCrack::API::Constants

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
        response =
          Unirest.get "#{API_HOST}/api/users/#{@user_id}/profiles/#{user_id}"

        if response.code != 200
          raise TriviaCrack::Errors::RequestError.new(response.code)
        end

        TriviaCrack::Parsers::ProfileParser.parse response.body
      end

    end
  end
end
