# Public: This error is raised when a web request to the Trivia Crack API is
# unsuccessful.
module TriviaCrack
  module Errors
    class RequestError < StandardError

      # Public: The HTTP status code returned by the Trivia Crack server.
      attr_reader :code

      # Public: Initializes a RequestError.
      #
      # code - The HTTP status code returned by the Trivia Crack server.
      def initialize(code)
        @code = code
      end
    end
  end
end
