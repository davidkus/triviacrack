require 'unirest'

require "triviacrack/api/game"
require "triviacrack/api/login"
require "triviacrack/api/profile"
require "triviacrack/api/question"
require "triviacrack/api/user"

# Public: Interface for interacting with the Trivia Crack API.
module TriviaCrack
  module API
    class Client

      # Public: Initialize a Trivia Crack API Client that can make requests to
      # the Trivia Crack API.
      def initialize
        Unirest.default_header "Content-Type", "application/json; charset=utf-8"
      end

      include TriviaCrack::API::Game
      include TriviaCrack::API::Login
      include TriviaCrack::API::User
      include TriviaCrack::API::Question
      include TriviaCrack::API::Profile

    end
  end
end
