# frozen_string_literal: true

require 'triviacrack/session'
require 'triviacrack/parsers/time_parser'

# Internal: This module is used to parse data returned from the Trivia Crack API
# into a ruby object that represents a Trivia Crack session.
module TriviaCrack
  module Parsers
    module SessionParser
      # Internal: Parses data returned from the Trivia Crack API to create a
      # TriviaCrack::Session object.
      #
      # raw_data  - A hash of the raw data returned by the Trivia Crack API.
      #
      # Examples
      #
      #   raw_data = get_raw_data_from_API
      #   ...
      #   session = TriviaCrack::Parsers::SessionParser.parse raw_data
      #
      # Returns a TriviaCrack::Session.
      def self.parse(raw_data)
        expiration = TimeParser.parse raw_data['session']['expirationTime']

        TriviaCrack::Session.new(
          session_id: raw_data['session']['session'],
          user_id: raw_data['id'],
          username: raw_data['username'],
          device_key: raw_data['session']['deviceKey'],
          expiration: expiration
        )
      end
    end
  end
end
