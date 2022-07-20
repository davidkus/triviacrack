# frozen_string_literal: true

require 'time'

# Internal: This module is used to parse date_time strings returned by the
# Trivia Crack API.
module TriviaCrack
  module Parsers
    module TimeParser
      TIME_FORMAT = '%m/%d/%Y %H:%M:%S'

      # Internal: Parses a date_time string returned by the Trivia Crack API.
      #
      # raw_data - The date_time string.
      #
      # Examples
      #
      #   TriviaCrack::Parsers::TimeParser.parse "02/17/2015 21:47:19 EST"
      #
      # Returns a Time object representation of the given string.
      def self.parse(raw_data)
        Time.strptime(raw_data, TIME_FORMAT)
      end
    end
  end
end
