# Public: This error is raised when a web request to the Trivia Crack API is
# unsuccessful.
module TriviaCrack
  module Errors
    class RequestError < StandardError

      # Public: The HTTP status code returned by the Trivia Crack server.
      attr_reader :code

      #Public: The URL that was requested.
      attr_reader :url

      #Public: The response body that was returned by the Trivia Crack server.
      attr_reader :body

      # Public: Initializes a RequestError.
      #
      # code - The HTTP status code returned by the Trivia Crack server.
      # url - The URL that was requested.
      # body - The response body that was returned by the Trivia Crack server.
      def initialize(code, url, body)
        @code = code
        @url = url
        @body = body
      end
    end
  end
end
