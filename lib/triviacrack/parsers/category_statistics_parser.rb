require "triviacrack/category_statistics"

# Internal: This module is used to parse data returned from the Trivia Crack API
# into a ruby object that represents category statistics for a Trivia Crack
# game.
module TriviaCrack
  module Parsers
    module CategoryStatisticsParser

      # Internal: Parses data returned from the Trivia Crack API to create a
      # TriviaCrack::CategoryStatistics object.
      #
      # raw_data - A hash of the raw data returned by the Trivia Crack API.
      #
      # Examples
      #
      #   raw_data = get_raw_data_from_API
      #   ...
      #   stats = TriviaCrack::Parsers::CategoryStatisticsParser.parse raw_data
      #
      # Returns a TriviaCrack::CategoryStatistics.
      def self.parse(raw_data)
        TriviaCrack::CategoryStatistics.new(
          category: raw_data["category"].downcase.to_sym,
          correct: raw_data["correct"],
          incorrect: raw_data["incorrect"],
          worst: raw_data["worst"]
        )
      end

    end
  end
end
